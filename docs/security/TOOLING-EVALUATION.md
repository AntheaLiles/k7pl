<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Évaluation prospective des outils de sécurité

Ce document recense des pistes à évaluer ; il ne déclare aucun outil adopté, aucune couverture de sécurité obtenue, ni aucun score OpenSSF amélioré. Chaque intégration devra être justifiée par une capacité utile à K7PL, validée sur une branche, puis mesurée sur des entrées représentatives.

## 1. SCA des dépendances Lake : OSV-Scanner en premier, SBOM séparée

### Constat et distinction des objectifs

`lake-manifest.json` contient les URL des dépôts Git et les SHA-1 de commit résolus pour les dépendances Lake. Ce sont des identifiants utilisables pour interroger des bases d'avis liées à des commits, mais ils ne sont pas des versions sémantiques et ne garantissent pas que chaque paquet ait des avis indexés.

La documentation OSV-Scanner prévoit un format d'entrée personnalisé pour les gestionnaires de paquets non pris en charge : chaque paquet peut être représenté par un nom de dépôt et un hash de commit. La documentation recommande de fournir un tel fichier `osv-scanner.json` via `--lockfile osv-scanner:<chemin>`. Cela fournit une voie d'essai concrète sans prétendre que `lake-manifest.json` est un lockfile natif OSV-Scanner. Références : [formats de manifeste pris en charge et lockfiles personnalisés](https://google.github.io/osv-scanner/supported-languages-and-lockfiles/), [API OSV par commit](https://google.github.io/osv.dev/post-v1-query/).

### Première intégration proposée

Le script `scripts/ci/lake_manifest_to_osv.py` valide le manifeste avec le contrôle structurel déjà utilisé par K7PL, puis produit un fichier temporaire dans le format OSV-Scanner. Il conserve l'URL de chaque dépôt et sa révision exacte, trie les entrées pour un résultat déterministe et refuse les manifestes qui ne passent pas les contrôles existants.

La CI prépare ce fichier, le transmet au workflow OSV-Scanner épinglé sur un SHA complet et publie les résultats dans GitHub Code Scanning. La première phase est volontairement **non bloquante en cas de vulnérabilité signalée** : il faut observer le résultat réel, vérifier la correspondance des dépendances, la couverture des avis et les faux positifs avant de transformer le scan en condition de fusion. Une erreur d'exécution ou d'extraction reste un problème à diagnostiquer, pas une preuve d'absence de vulnérabilités.

**Limite majeure :** le scan par commit n'est pas une analyse complète du code, une preuve d'absence de vulnérabilités, ni une SBOM normalisée. Une absence de résultat peut signifier qu'aucun avis connu ne correspond à ce commit dans OSV. Elle ne démontre pas l'absence de défauts ni la couverture de tous les composants transitifs.

### Premier résultat observé

Le run GitHub Actions [37951599075](https://github.com/AntheaLiles/k7pl/actions/runs/37951599075), sur le commit `7b72150f045ac5a6dc1f98bfd230d422baa94e47`, a exécuté OSV-Scanner v2.6.0 sur le fichier personnalisé. Le journal confirme que **14 paquets** ont été extraits, que le scan a terminé avec le code 0 et que le rapport a affiché `No issues found`. Le fichier SARIF a été validé et envoyé à GitHub Code Scanning.

Ce résultat établit que l'adaptateur et le chemin d'exécution fonctionnent pour le manifeste actuel. Il ne prouve pas que chaque dépendance a des avis indexés dans OSV ni que toutes les vulnérabilités possibles sont couvertes. Le scan reste non bloquant ; le suivi périodique, la couverture des avis et le processus de triage restent à établir.

### Place des autres outils

- **Syft + Grype :** Syft catalogue des composants qu'il sait reconnaître dans un répertoire, une archive ou une image ; Grype recherche des vulnérabilités dans les composants identifiés d'une SBOM. Cette chaîne mérite un essai ultérieur sur les artefacts réellement livrés, mais elle ne remplace pas l'extraction explicite des dépendances Lake depuis le manifeste. Sources : [sources Syft](https://github.com/anchore/syft/wiki/Supported-Sources), [cibles de scan Grype](https://github.com/anchore/grype).
- **ORT :** outil pertinent pour la conformité des licences, les politiques et les rapports. Lake n'apparaît pas dans la liste documentée des gestionnaires natifs ; il faut fournir un inventaire via le mécanisme de repli SPDX ou une définition ORT manuelle, puis vérifier l'exactitude des résultats. Source : [ORT Analyzer](https://oss-review-toolkit.org/ort/docs/tools/analyzer).
- **REUSE :** `reuse lint` vérifie les déclarations de licence des fichiers du dépôt. `reuse spdx` peut produire un document SPDX sur le contenu qu'il sait analyser. Ces contrôles ne suffisent pas à établir les licences des dépendances amont ni leur compatibilité juridique.
- **sbomqs :** évalue la qualité d'une SBOM existante ; il ne génère pas à lui seul l'inventaire.

### Critères avant de rendre le scan bloquant

- [ ] Confirmer en CI que chaque entrée du manifeste est extraite et transmise à OSV-Scanner.
- [ ] Inspecter le premier rapport et établir la couverture réelle sur les 14 dépendances allowlistées.
- [ ] Vérifier si les avis OSV correspondent à des commits, tags ou versions et documenter les angles morts.
- [ ] Définir une procédure de triage des avis, de justification des faux positifs et de suivi des corrections.
- [ ] Ne rendre le scan bloquant qu'après examen du résultat initial et décision sur les règles de sévérité.
- [ ] Traiter la SBOM SPDX/CycloneDX comme un chantier distinct : identifier les composants, versions, licences et relations ; valider le fichier avec un outil indépendant ; ne pas la déclarer exhaustive sans preuve.

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
