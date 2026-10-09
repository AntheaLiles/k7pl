<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Évaluation prospective des outils de sécurité

Ce document recense des pistes à évaluer ; il ne déclare aucun outil adopté, aucune couverture de sécurité obtenue, ni aucun score OpenSSF amélioré. Chaque intégration devra être justifiée par une capacité utile à K7PL, validée sur une branche, puis mesurée sur des entrées représentatives.

## 1. SBOM standardisée : génération puis contrôle de qualité

### Constat et objectif

`lake-manifest.json` verrouille les dépendances Lake par révision, mais ce n'est pas à lui seul une SBOM standardisée décrivant les composants et leurs métadonnées dans un format d'échange. K7PL ne produit actuellement pas de SBOM. L'objectif potentiel est de produire un inventaire traçable des dépendances du dépôt et de ses artefacts publiés, en distinguant au besoin dépendances Lake, outillage Python et composants de la chaîne CI.

### Outil candidat

Le lien fourni, [interlynk-io/sbomqset](https://github.com/interlynk-io/sbomqset), semble contenir une coquille dans le nom du dépôt. Le projet Interlynk retrouvé est [interlynk-io/sbomqs](https://github.com/interlynk-io/sbomqs), un outil d'évaluation de la qualité et de la conformité d'une SBOM, notamment aux formats SPDX et CycloneDX. **sbomqs évalue une SBOM ; ce n'est pas en soi un générateur de SBOM.** Il ne faut donc pas le présenter comme le générateur standardisé recherché.

### Hypothèse d'architecture

1. Identifier un générateur qui sait représenter correctement les dépendances Lean/Lake à partir de `lake-manifest.json`, et non simplement les fichiers du dépôt.
2. Définir le périmètre de l'inventaire : dépendances directes et transitives, composants de build, actions GitHub et/ou artefacts publiés. Les sources de données et les omissions doivent être explicites.
3. Générer un format d'échange standard, SPDX ou CycloneDX, puis valider sa structure et sa complétude.
4. Évaluer `sbomqs` comme contrôle qualité secondaire, sans confondre score de qualité et exhaustivité réelle de l'inventaire.
5. Envisager la publication de la SBOM avec les artefacts de release seulement après une validation reproductible et une décision de maintenance.

### Critères d'acceptation d'une étude

- [ ] Le générateur couvre réellement le graphe Lake utilisé par K7PL ou documente précisément les lacunes.
- [ ] Les composants et versions produits sont comparés au manifeste source ; les dépendances absentes et fausses positives sont testées.
- [ ] Le fichier produit est validé par un parseur indépendant SPDX/CycloneDX.
- [ ] La génération est déterministe, ou les différences non déterministes sont caractérisées.
- [ ] La SBOM n'est pas qualifiée de complète au-delà de son périmètre mesuré.
- [ ] Le coût d'installation et la chaîne de confiance de l'outil sont évalués avant toute intégration CI.

## 2. Fuzzing ciblant Lean 4

Candidat : [kiranandcode/lean-fuzz](https://github.com/kiranandcode/lean-fuzz).

Le fuzzing n'est pertinent que si une entrée générée traverse une surface réelle du système. À l'état actuel, l'implémentation K7PL est réduite et ne présente pas encore de parseur ou d'interface d'entrée comparable à celle d'un langage opérationnel. Fuzzer dès maintenant le seul noyau sémantique pourrait surtout produire un contrôle décoratif, sans accroître sensiblement l'assurance.

L'évaluation devra vérifier ce que `lean-fuzz` génère réellement, comment il exécute les cas, quels oracles il utilise, s'il peut cibler les fonctions et types de K7PL, et comment les échecs sont minimisés et reproduits. L'existence du dépôt ne prouve ni sa maintenance, ni sa compatibilité avec la version Lean épinglée dans `lean-toolchain`, ni sa pertinence pour K7PL.

Une réimplémentation ne se justifierait que si l'outil existant est incompatible ou insuffisant, et après définition d'un contrat de fuzzing précis : générateur d'entrées, oracle indépendant, déterminisme du seed, réduction des contre-exemples, budget d'exécution et corpus de régression.

- [ ] Lire le code, la licence, l'activité de maintenance et les exigences de version.
- [ ] Identifier une cible K7PL avec une entrée non triviale et un oracle indépendant.
- [ ] Démontrer qu'un cas fautif est détecté et qu'un cas témoin valide passe.
- [ ] Vérifier la reproductibilité et l'enregistrement des contre-exemples.
- [ ] N'ajouter un job CI qu'après mesure du coût et du signal utile.

## 3. Analyse statique (SAST) de Lean 4

Candidat : [dmbs335/pc-sast-lean](https://github.com/dmbs335/pc-sast-lean).

L'existence d'un outil se présentant comme un SAST pour Lean 4 ne démontre pas sa capacité à analyser le code K7PL ni à détecter une classe de défauts pertinente. Avant adoption, il faut examiner les règles, la couverture syntaxique et sémantique, les faux positifs, les faux négatifs connus, la maintenance et la compatibilité avec le toolchain du dépôt.

L'évaluation doit distinguer trois couches : (1) défauts de code Lean détectables par analyse statique, (2) erreurs de preuve ou usages d'axiomes déjà couverts en partie par les audits existants, (3) défauts de workflows et de dépendances, qui relèvent d'outils d'analyse de CI et de chaîne d'approvisionnement plutôt que d'un SAST Lean. Le SARIF de Scorecard n'est pas, à lui seul, une analyse statique du code Lean.

- [ ] Vérifier la licence, la maintenance, les règles et les dépendances de l'outil.
- [ ] Construire un corpus contrôlé de défauts positifs et de cas négatifs, sans introduire ces défauts dans `main`.
- [ ] Mesurer séparément vrais positifs, faux positifs et défauts non détectés sur ce corpus.
- [ ] Comparer les résultats aux contrôles déjà présents : `lake lint`, compilation, tests et audit d'axiomes.
- [ ] Si l'outil est inadéquat, documenter les lacunes avant de décider d'une extension ou d'une réimplémentation ciblée.
- [ ] Ne revendiquer aucune couverture SAST tant qu'une évaluation reproductible ne la démontre pas.

## 4. Gouvernance des branches et actions GitHub

Les avertissements génériques sur la protection de branche ne doivent pas être corrigés mécaniquement au prix d'une règle impossible à satisfaire ou d'un verrouillage de l'unique mainteneuse. Le dépôt a historiquement un seul humain en mesure de relire ; une approbation exigée sans second relecteur serait une protection inopérante ou un blocage. Un fichier `CODEOWNERS` pointant vers la seule mainteneuse ne crée pas de revue indépendante.

| Contrôle | Recommandation | État / action |
|---|---|---|
| Suppression de `main` | Interdire | Déjà rapporté comme désactivé |
| Force-push sur `main` | Interdire | Déjà rapporté comme désactivé |
| PR obligatoire | Exiger | Déjà en place selon l'audit du dépôt |
| Checks requis | Exiger le check global pertinent et activer la politique stricte « branche à jour » | Vérifier le nom exact du check et la compatibilité avec le flux CI avant modification |
| Rejet des approbations obsolètes | Activer si les approbations sont utilisées | Utile dès qu'une revue réelle existe |
| Approbation du dernier push | Activer lorsque la politique de revue et les capacités GitHub le permettent | À vérifier après définition d'une politique de revue réelle |
| Nombre d'approbations requis | À décider selon le nombre de mainteneurs capables de relire | Ne pas simuler une approbation indépendante ; réévaluer lorsqu'un second humain est disponible |
| Revue CODEOWNERS | Ne pas la déclarer effective sans propriétaire distinct et actif | Aucun bénéfice réel avec un seul propriétaire |
| Application aux administrateurs | Activer si cela ne crée pas de chemin de blocage sans récupération | Vérifier l'accès de récupération avant le changement |
| Branches de release et tags | Définir explicitement les motifs de branches/tags réellement utilisés et empêcher les déplacements non autorisés | Action humaine GitHub à instruire ; ne pas appliquer une règle non testée à l'aveugle |

Les paramètres de dépôt sont distincts des fichiers versionnés. Cette pull request peut documenter la politique et la procédure de vérification ; elle ne prouve pas que les paramètres effectifs ont changé. Après toute modification dans GitHub, relever la configuration observée, le périmètre des branches, les checks exigés et un test de fonctionnement sans fusionner de changement risqué.

## 5. Ordre de travail proposé

1. **SBOM** : étude de faisabilité du générateur compatible Lake, puis contrôle du document produit par un validateur standard.
2. **SAST Lean** : corpus contrôlé et évaluation de `pc-sast-lean` avant décision d'intégration.
3. **Fuzzing** : attendre une cible d'entrée utile ou définir explicitement une cible générative et un oracle indépendants.
4. **Gouvernance GitHub** : vérifier les réglages en lecture, décider des contrôles compatibles avec le modèle de maintenance, puis appliquer séparément les changements administratifs.

Aucune de ces pistes ne doit être intégrée uniquement pour améliorer un score. Les statuts ne passeront à `VERIFIED` qu'après une vérification observable, consignée avec son résultat.
