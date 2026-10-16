<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Chantier K — Assurance de conformité outillée avec Lean 4

**État de reprise au 2026-10-16 :** `main` était à `e37f749fd495e019dd60b73122ea56e0ff2a6e72` lors de la vérification du dépôt ; `lean-toolchain` reste fixé à Lean 4.34.0. Les PR [#128](https://github.com/AntheaLiles/k7pl/pull/128), [#147](https://github.com/AntheaLiles/k7pl/pull/147) et [#151](https://github.com/AntheaLiles/k7pl/pull/151) sont fusionnées. Le fichier [`docs/STATUS.md`](../STATUS.md), généré pour `676ee66f659ec143c6d065954886e42019c29941`, atteste le succès du contrôle agrégé pour cette révision ; cela ne constitue pas une preuve CI attachée au commit ultérieur de mise à jour du statut. Trois exécutions CI complètes indépendantes sur le code d’évaluation ont été vérifiées comme `success` : [#38118879020](https://github.com/AntheaLiles/k7pl/actions/runs/38118879020), [#38119278580](https://github.com/AntheaLiles/k7pl/actions/runs/38119278580) et [#38119675470](https://github.com/AntheaLiles/k7pl/actions/runs/38119675470). Les mesures de ces runs sont historiques (11 octobre), non des mesures du commit `main` actuel. L’évaluation reste bornée : elle n’établit ni l’exhaustivité du SBOM, ni la véracité des métadonnées, ni l’absence de vulnérabilités, ni une conformité globale.

## 1. Objet et décisions antérieures récupérées

L'issue [#122](https://github.com/AntheaLiles/k7pl/issues/122) ouvre une recherche sur le rôle de Lean dans l'assurance de conformité. Elle n'autorise ni une modification de la spécification normative de K7PL, ni une modification sémantique de son implémentation. Elle exige de distinguer règles formalisées, traçabilité, preuves, résultats empiriques et décision humaine.

La [PR #121](https://github.com/AntheaLiles/k7pl/pull/121) est fusionnée. Elle sépare ce chantier de la campagne OpenSSF, mise en pause. Le présent document ne rouvre pas cette campagne et ne transforme pas son état en conformité vérifiée.

Les décisions antérieures récupérables dans le dépôt sont les suivantes :

- `docs/security/LEAN-SECURITY-TOOLCHAIN.md` propose un modèle interne indépendant des formats, des adaptateurs d'entrée et de sortie, des règles formelles bornées, ainsi que des validations indépendantes des documents exportés.
- `docs/security/TOOLING-EVALUATION.md` propose OSV-Scanner pour le premier scan SCA, maintient la SBOM comme sujet distinct, identifie Syft/Grype/ORT comme candidats à évaluer, et exige une évaluation contrôlée du SAST Lean.
- La [PR #113](https://github.com/AntheaLiles/k7pl/pull/113) a livré le générateur SPDX 2.3 borné aux entrées de `lake-manifest.json`, avec conservation des URL/révisions, `NOASSERTION` pour les champs non établis et tests hors ligne.
- Cette absence de validation indépendante décrit l'état historique avant le démonstrateur suivant ; elle n'est plus l'état courant. La [PR #128](https://github.com/AntheaLiles/k7pl/pull/128) est fusionnée : son audit Lean vérifie un contrat explicite sur les champs normalisés, et le document produit a été accepté par `spdx-tools 0.8.5` verrouillé dans le run CI [#891](https://github.com/AntheaLiles/k7pl/actions/runs/38063142568). Les limites et travaux encore ouverts sont consignés aux sections 5 et 6 ci-dessous. Aucun choix n'est établi quant à la réimplémentation de moteurs externes complets.

L'issue #122 ne comporte aucun commentaire décisionnel au moment de l'inventaire. Aucune décision spécifique WCAG/ARIA ni aucun prototype CycloneDX/accessibilité n'a été retrouvé par les recherches de fichiers. Cela signifie « non identifié dans les éléments examinés », non une preuve absolue d'absence dans tout historique inaccessible.

## 2. Carte de l'existant

| Élément | État observé | Limite à conserver |
|---|---|---|
| Toolchain | Lean 4.34.0 dans `lean-toolchain` ; Lake configuré dans `lakefile.lean` | Les ajouts doivent respecter la version déjà épinglée |
| Dépendances | `lake-manifest.json` comporte 14 entrées Git avec des révisions exactes | Le manifeste aplati ne suffit pas à établir toutes les arêtes ni l'exhaustivité de la chaîne de fabrication |
| Contrôle du manifeste | `scripts/ci/check_manifest.py` et `test_check_manifest.py` | Contrôle les invariants locaux et une liste de paquets autorisés ; les contrôles amont réseau sont une étape distincte |
| SCA | `scripts/ci/lake_manifest_to_osv.py`, tests et scan OSV documenté | Une requête d'avis par commit n'est pas une SBOM ni une preuve d'absence de vulnérabilité |
| SPDX | `scripts/ci/lake_manifest_to_spdx.py`, `scripts/ci/validate_spdx.py` et leurs tests | Générateur limité au manifeste Lake ; validation indépendante `spdx-tools 0.8.5` intégrée expérimentalement, avec garde locale pour le défaut amont #885 |
| CycloneDX | Pas de générateur identifié dans les fichiers examinés | Candidat à décider seulement sur la base de consommateurs et de besoins réels |
| SAST Lean | Candidat `dmbs335/pc-sast-lean` documenté, non qualifié pour K7PL | Licence, maintenance, règles, couverture, faux positifs et faux négatifs à mesurer |
| SAST workflows | `actionlint` et `zizmor` intégrés | Leur succès d'exécution ne signifie pas qu'aucun constat n'existe ; la politique de blocage reste distincte |
| REUSE / licences | `reuse lint` et contrôles de métadonnées des fichiers | Ne qualifie pas à lui seul les licences des dépendances amont ni leur compatibilité juridique |
| Vérification Lean | Compilation, tests, linters et audits d'axiomes dans la CI | Vérifier les preuves des modules compilés ne démontre ni l'exhaustivité de l'assurance ni la conformité organisationnelle |
| WCAG / ARIA | Aucun prototype repéré pendant cette passe | L'applicabilité doit être établie sur des artefacts concrets ; les tests automatiques ne couvrent pas tous les critères ni l'usage réel |
| Fuzzing | Candidat `kiranandcode/lean-fuzz` cité dans l'évaluation d'outillage | Aucune cible nouvelle ne doit être créée sans entrée réellement exposée et oracle indépendant |

## 3. Matrice de faisabilité et priorité

Échelle qualitative : **forte**, **moyenne**, **faible**. La valeur de formalisation évalue les propriétés bornées qui peuvent être vérifiées, et non la possibilité théorique d'écrire des types en Lean.

| Domaine | Valeur pour K7PL | Faisabilité de départ | Rôle recommandé de Lean | Moteur complémentaire / frontière |
|---|---|---|---|---|
| Cohérence SBOM SPDX Lake | Forte : prototype déjà présent et lacune de validation identifiée | Forte | Noyau de règles et vérificateur d'invariants sur un modèle normalisé | Validateur SPDX indépendant pour le format complet ; le présent prototype ne le remplace pas |
| SCA Lake / OSV | Forte : chemin actuel existe et produit des résultats | Forte pour les adaptateurs, moyenne pour un modèle formel | Vérifier identités, états, provenance et politiques explicites | OSV-Scanner reste le moteur d'avis ; zéro constat ne signifie pas zéro vulnérabilité |
| Licences et politiques | Moyenne à forte | Moyenne | Vérifier règles structurées et conséquences dans un périmètre déclaré | Évaluer ORT et ses entrées ; ne pas déduire la compatibilité juridique de simples étiquettes |
| CycloneDX | Moyenne, à confirmer par les consommateurs | Moyenne après stabilisation du modèle | Sérialiser et contrôler les invariants communs effectivement équivalents | Schéma/validateur de la version CycloneDX retenue ; ne pas supposer une conversion sans perte depuis SPDX |
| SAST Lean | À confirmer par corpus de défauts | Moyenne ou faible avant évaluation | Formaliser des règles ciblées, pas remplacer à l'aveugle l'analyseur | Évaluer `pc-sast-lean` contre la compilation, les linters, tests et audits d'axiomes |
| SAST GitHub Actions | Forte mais déjà couverte en partie | Forte | Éventuel contrôle de cohérence de politiques, non moteur de détection principal | Garder `actionlint` / `zizmor` ; pas de réimplémentation décorative |
| WCAG / ARIA | Non démontrée sans cas d'usage ciblé | Faible pour une conformité générale en Lean | Vérifier, au plus, des propriétés de composants/modèles explicitement définies | Analyse statique et DOM/runtime, tests clavier/lecteurs d'écran, revue humaine |
| Fuzzing | Dépend des surfaces d'entrée exposées | Moyenne pour les parseurs/adaptateurs | Propriétés d'invariants et oracle borné | Générateur, corpus à graine enregistrée, tests différentiels et minimisation des contre-exemples |
| Provenance/release | Forte sur la chaîne de livraison, mais hors du premier PoC | Moyenne | Vérifier une relation déclarée entre source, identité, artefact et preuve importée | Attestations, empreintes et contrôles de signature ; les métadonnées seules n'établissent pas la provenance réelle |

### Comparaison des architectures

| Architecture | Avantage | Risque | Position |
|---|---|---|---|
| Réimplémentation native Lean | Peut donner une preuve précise sur la logique réimplémentée | Réimplémentation coûteuse et potentiellement divergente d'un standard ou d'un moteur existant | Ne retenir que pour des noyaux petits et justifiés |
| Enveloppe Lean autour de résultats tiers | Intégration et politiques auditables sans remplacer le moteur | Une sortie importée reste une donnée non fiable ; son import ne prouve pas le résultat externe | Appropriée si le contrat d'entrée est explicite |
| Pipeline hybride | Sépare parsing, normalisation, règles, analyse externe et validation | Nécessite de définir et tester les interfaces et la provenance | **Retenue** |

## 4. Architecture minimale retenue

Le flux proposé est :

1. **Acquisition** : récupérer des fichiers appartenant à une révision connue ; traiter les résultats tiers comme des entrées non fiables.
2. **Parsing** : analyser JSON avec un parseur explicite ; rejeter les champs requis manquants ou de mauvais type. Pour SPDX, exécuter aussi un validateur indépendant épinglé après résolution des exigences de version, d'intégrité et de chaîne d'approvisionnement.
3. **Normalisation** : traduire seulement les champs utiles vers des structures Lean typées. Ne jamais transformer un champ inconnu en valeur affirmée.
4. **Règles** : exprimer le contrat propre au cas d'usage et les politiques de décision sous forme de prédicats.
5. **Vérification** : le noyau Lean vérifie les théorèmes sur le modèle normalisé ; le rapport garde distinct le résultat du validateur externe.
6. **Rapport** : produire un JSON stable avec version de schéma, outil et version, statut `PASS/FAIL/ERROR`, diagnostics identifiés par règle, artefacts source, périmètre et limites.
7. **Preuves et provenance** : relier chaque affirmation à la règle et au source Lean correspondant ; ajouter avant toute généralisation les révisions, empreintes des entrées, versions effectives des analyseurs et liens vers les artefacts de vérification.

Le rapport natif Lean conserve les chemins et le périmètre, sans calculer les empreintes cryptographiques. La CI produit une enveloppe d'évidence distincte, calculée avec la bibliothèque standard Python, qui enregistre SHA-256 du manifeste, du `lakefile.lean`, du toolchain, des sources d'audit/génération et du SBOM ; elle relève aussi le commit testé et la tête de PR. Cette enveloppe n'est pas une preuve Lean de provenance : c'est une attestation du workflow conservée comme artefact CI. L'intégration de génération/validation, les cas CLI négatifs et les artefacts de mesure ont passé le run #891.

## 5. Démonstrateur : audit de cohérence Lake ↔ SPDX 2.3

### Revendication visée

Pour les champs représentés dans les deux documents effectivement lus, l'audit détermine si l'inventaire SPDX satisfait un contrat borné qui préserve les noms de paquets, URL et révisions du manifeste Lake, et respecte la convention actuelle d'identifiants, de métadonnées inconnues et de relations `DESCRIBES`.

La revendication porte sur **les données observées**, pas sur leur exhaustivité. Le théorème Lean `Compliance.SbomAudit.verifyContract_sound` relie un résultat de décision réussi au prédicat `InventoryContract` pour le modèle normalisé. Il ne démontre pas la correction de la lecture des fichiers, la conformité complète au schéma SPDX, ni la véracité de faits externes.

### Invariants couverts

- manifeste identifié comme `k7pl` et document SPDX déclaré `SPDX-2.3` ;
- révision Lake de 40 caractères hexadécimaux minuscules ;
- égalité des ensembles de composants sur le nom, l'URL et la révision exacte encodée dans `versionInfo` ;
- unicité des noms de paquets et des identifiants SPDX ;
- conservation de `NOASSERTION` pour licence déclarée, licence conclue et copyright ;
- nombre, unicité et cible des relations cohérents : exactement une relation `SPDXRef-DOCUMENT DESCRIBES` par paquet, sans arête `DEPENDS_ON` inventée.

### Cas de test

Les tests Lean couvrent un cas positif ainsi que des cas négatifs pour format de révision invalide, révision modifiée, URL modifiée, métadonnée de licence affirmée, relation inventée, relation manquante, identifiants dupliqués et champ requis absent.

La CI #891 a compilé la bibliothèque et le CLI, généré puis audité le SBOM issu des 14 entrées du vrai manifeste, vérifié le rapport JSON, exécuté `lake test`, `lake lint` et les audits d'axiomes. Les tests end-to-end couvrent : JSON de manifeste malformé → `ERROR`/code 2 ; révision de composant falsifiée → `FAIL`/code 1 ; nom de paquet vide → garde `FAIL`/code 1 avant l'appel au validateur externe. L'artefact `k7pl-independent-spdx-validation-38063142568` contient le SBOM, le rapport `PASS` pour `spdx-tools 0.8.5` et le rapport de mesure répétée, avec SHA-256 identique sur les cinq échantillons.

### Validation indépendante : état du candidat au 10 octobre 2026

Le candidat officiel [`spdx-tools` v0.8.5](https://github.com/spdx/tools-python/releases/tag/v0.8.5) annonce une validation complète contre SPDX 2.2 et 2.3. Toutefois, l'issue upstream [#885 — Package without a name is not flagged as invalid](https://github.com/spdx/tools-python/issues/885) reste ouverte et décrit un document où le nom du paquet est vide sans constat de validité. Le validateur ne doit donc pas être traité comme un oracle infaillible.

Le validateur est intégré expérimentalement au job Python de la CI. `scripts/requirements-spdx-validator.txt` verrouille les versions et les hashes de la fermeture de dépendances ; l'installation avec `--require-hashes --only-binary=:all:` et la validation du SBOM ont réussi dans #891. Le garde local rejette les noms de paquets absents ou vides avant l'appel externe ; les tests de régression passent. L'issue upstream #885 reste ouverte : le garde couvre ce défaut connu, mais ne démontre pas l'absence d'autres lacunes du validateur. Le `PASS` concerne uniquement le document identifié par son SHA-256 `a795763270df820df406f0f140cb352a469d636c6d7ec6f99447aef07fba161c`, pas l'exhaustivité de l'inventaire.

### Critères d'acceptation

- tous les modules Lean du prototype sont effectivement compilés par la cible déclarée ;
- tests positifs et négatifs réussis ;
- rapport JSON stable dans sa structure, avec statut exploitable et diagnostics identifiables ;
- comportement CLI distinct pour succès, non-conformité au contrat et entrée malformée/illisible ;
- génération déterministe pour un manifeste et un horodatage donnés, vérifiée au niveau CLI sur l'égalité octet pour octet des fichiers produits ;
- durée du wrapper et du sous-processus de validation conservées dans le rapport d'évidence ; cette mesure descriptive ne constitue pas un benchmark multi-run ;
- validation SPDX 2.3 indépendante de la sortie réelle, version `spdx-tools 0.8.5` et fermeture hash-lockée, réussie dans la CI #891 ; le garde #885 est testé, mais d'autres lacunes restent possibles ;
- pas de modification de la spécification normative ou de la sémantique de K7PL ;
- la CI #891 a validé le démonstrateur, la validation externe du document SPDX 2.3 et le micro-benchmark sur cinq répétitions ; cela n'établit ni l'exhaustivité du SBOM, ni l'absence d'autres lacunes de validation, ni la conformité globale de K7PL.

## 6. Séquencement et statuts

### Cinq points du chantier de reprise — reconstruction documentaire

Le texte exact des cinq points de l'échange antérieur « Analyser le plan Lean » n'est pas versionné dans les sources consultées. Le tableau suivant est une **reconstruction opérationnelle**, fondée sur les artefacts du dépôt et les validations observables ; il ne reproduit pas des intitulés supposés de l'ancien échange et ne correspond pas aux six phases A–F décrites plus bas.

| Point reconstruit | Résultat attendu | État vérifié et preuve | Écart restant | Critère d'achèvement |
|---|---|---|---|---|
| 1. Inventorier les sources, décisions et états de livraison | Retrouver la base actuelle sans se fier aux anciens comptes rendus seuls | Réalisé avant le présent lot ; `main` observé au SHA `2c7c8a0c16489c44cd1fbee80eb6959a31b25daa`. Les fusions #54, #128 et #129, les PR ouvertes et leurs checks ont été revérifiés. | Le libellé d'origine du point n'est pas récupérable ; ce manque est explicitement conservé. | Le plan distingue sources versionnées, faits CI, états PR et obligations restantes ; satisfait pour le périmètre Lean/SBOM. |
| 2. Établir la faisabilité et la frontière de garantie | Justifier le contrat borné Lean, le générateur existant et la validation indépendante | Conçu et documenté dans les sections précédentes de cette note ; PR #128 et CI #891 attestent le prototype retenu. | Les extensions SCA/SAST/CycloneDX et l'usage en production ne sont pas décidés ; ce n'est pas un résultat implicite de faisabilité. | Architecture et limites exposées ; GO recherche bornée, NO-GO conformité de production ; satisfait. |
| 3. Terminer et clôturer le démonstrateur Lake→SPDX | Générer, auditer et valider le document SPDX sur son périmètre annoncé, puis synchroniser les plans | Prototype fusionné par [PR #128](https://github.com/AntheaLiles/k7pl/pull/128) ; CI [#891](https://github.com/AntheaLiles/k7pl/actions/runs/38063142568) et [#38086816755](https://github.com/AntheaLiles/k7pl/actions/runs/38086816755) vertes. Cette PR synchronise les notes actives avec l'état réel. | La SBOM ne couvre que les entrées Lake et ne prouve ni exhaustivité, ni absence de vulnérabilités, ni conformité globale. | Build/audit/test, validation SPDX indépendante, empreintes conservées et sources de suivi cohérentes ; satisfait pour le prototype borné. |
| 4. Élargir la couverture des diagnostics du wrapper | Tester les branches de succès, d'échec et d'erreur sans introduire un nouveau contrôle bloquant | `scripts/ci/test_validate_spdx.py` compte 19 tests et passe. Les observations les plus récentes conservées dans le workflow #38953520978 comprennent 17 mutations structurées et deux entrées JSON brutes ; voir [`SPDX-NEGATIVE-CORPUS-REVIEW.md`](SPDX-NEGATIVE-CORPUS-REVIEW.md) pour les hashes, résultats et qualifications provisoires. | Le corpus est exploratoire ; la revue normative des chaînes vides et la frontière entre SPDX générique et profil K7PL restent à ratifier. Ni ce rapport ni les tests unitaires ne démontrent une couverture complète du schéma. | Tests de branches et signal empirique non bloquant — atteint ; revue normative humaine et qualification de l'oracle restent ouvertes. |
| 5. Évaluer la variabilité inter-run et décider de la suite | Comparer les mêmes entrées et outils entre plusieurs exécutions indépendantes ; fonder toute extension sur les résultats | Quatre ensembles de mesures historiques utilisent la même entrée SHA-256 `a795763270df820df406f0f140cb352a469d636c6d7ec6f99447aef07fba161c`; trois workflows complets (#38118879020, #38119278580, #38119675470) sont terminés avec `success`, cinq échantillons chacun et hashes identiques. #38118745654 a été annulé après le job Python et n'est pas compté comme CI complète. Le corpus est qualifié provisoirement dans [`SPDX-NEGATIVE-CORPUS-REVIEW.md`](SPDX-NEGATIVE-CORPUS-REVIEW.md). | Les différences entre runners sont descriptives et les effets cache/charge ne sont pas isolés causalement. L'oracle normatif et les cas ambigus ne sont pas encore ratifiés humainement. | La mesure multi-run historique est acquise ; réexécuter le corpus avec provenance v2, vérifier l'artefact, faire ratifier les cas ambigus et décider si un sous-ensemble qualifié peut devenir bloquant. La porte de conformité globale reste NO-GO. |

| Lot | État | Critère de sortie |
|---|---|---|
| A — inventaire et récupération des décisions | **Exploré** | Sources repérées ; limites et décisions non récupérables explicites |
| B — faisabilité et architecture | **Conçu** | Matrice et frontières ci-dessus documentées |
| C — contrat SPDX minimal | **Conçu** | Invariants du modèle normalisé explicités |
| D — prototype Lean/CLI/tests | **Testé en CI (#891)** | Compilation, audit d'inventaire, tests positifs/négatifs, lint, audits d'axiomes et artefacts de preuve validés sur la tête de PR `69368cea93b9c0fc25d2164b8052e90a85e1690a` |
| E — validation SPDX indépendante | **Intégration expérimentale réussie en CI (#891)** | Document précis accepté par `spdx-tools 0.8.5`, fermeture hash-lockée et garde pour l'issue amont #885 ; d'autres limites sont possibles |
| F — évaluation | **Comparaison préliminaire sur deux runs ; corpus externe négatif et évaluation élargie ouverts** | Conserver les empreintes identiques de l'entrée et des outils, caractériser davantage de runs indépendants ; tester des documents SPDX négatifs au-delà du garde local ; mesurer couverture et classes de diagnostic |
| Extension SCA/SAST/CycloneDX/WCAG | **À prioriser après évaluation** | Décision fondée sur le prototype, le bénéfice et les dépendances communes |

### Évaluation empirique : baseline et micro-mesure

Les métadonnées du run CI #877 enregistrent environ 5 min 46 s pour le workflow complet, 4 min 56 s pour le job Lean, 2 min 21 s pour l'étape `lake test` et 18 s pour le job Python. Ces durées de CI incluent installation, cache, initialisation et contrôles annexes ; elles ne mesurent pas isolément le validateur.

Le run #887 a mesuré une première invocation de validation à 543,202 ms pour le sous-processus `pyspdxtools` et 556,297 ms pour le wrapper. Dans le run #891, l'invocation autonome préalable aux répétitions a pris 496,043 ms pour `pyspdxtools` et 508,578 ms pour le wrapper. Les cinq invocations suivantes, exécutées séparément sur le même runner et sur le même document, ont toutes renvoyé `PASS`, sans diagnostic, avec le même SHA-256 `a795763270df820df406f0f140cb352a469d636c6d7ec6f99447aef07fba161c`.

| Run CI | Mesure sur cinq répétitions | Min. | Médiane | Max. |
|---|---|---:|---:|---:|
| #891 | Processus CLI complet, démarrage Python inclus | 378,237 ms | 381,283 ms | 389,103 ms |
| #891 | Wrapper `validate_spdx.py` (après imports) | 314,895 ms | 316,976 ms | 325,656 ms |
| #891 | Sous-processus `pyspdxtools` seul | 302,409 ms | 304,564 ms | 313,096 ms |
| #38086816755 | Processus CLI complet, démarrage Python inclus | 327,807 ms | 345,772 ms | 348,941 ms |
| #38086816755 | Wrapper `validate_spdx.py` (après imports) | 272,527 ms | 288,930 ms | 293,715 ms |
| #38086816755 | Sous-processus `pyspdxtools` seul | 261,066 ms | 277,628 ms | 282,120 ms |

Les deux rapports indépendants enregistrent Python 3.13.16, la même plateforme `Linux-6.17.0-1022-azure-x86_64-with-glibc2.39`, le SHA-256 d'entrée `a795763270df820df406f0f140cb352a469d636c6d7ec6f99447aef07fba161c`, le même SHA du script de validation `279ed992c4cf534539a27179cacefa998c35fee7e1cf2427e5268c95dad3fe03` et du verrou `300e52cba5c20930dfd2e7a9a1ef6042d057e56336de6ae58c67ff14b0646632`. Dans les cinq répétitions, l'entrée n'a pas changé et chaque invocation a renvoyé `PASS` sans diagnostic.

La médiane du sous-processus `pyspdxtools` passe descriptivement de 304,564 ms dans #891 à 277,628 ms dans #38086816755 ; les médianes wrapper et processus complet varient aussi. Les invocations autonomes préalables étaient plus lentes que les répétitions dans les deux runs (496,043 ms puis 512,303 ms pour le validateur seul). Cette variation est compatible avec des effets d'initialisation/cache, mais les mesures ne permettent pas d'en attribuer la cause. Même si les deux rapports ont le même document, les versions et l'environnement consignés, deux runs de cinq échantillons ne constituent ni un benchmark multi-machine ni une estimation robuste de variance.

La CI produit les durées monotones dans les rapports et résumés ; une fixture CLI vérifie l'égalité **octet pour octet** de deux sorties du générateur pour le même manifeste, le même toolchain et un horodatage fixé. Une première comparaison inter-run est désormais documentée ; il reste à répéter l'expérience selon un protocole contrôlé et à élargir le corpus négatif pour caractériser couverture, diagnostics et autres limites du validateur.

### Corpus négatif historique (ancien harness, non bloquant)

Le run CI [#38087621350](https://github.com/AntheaLiles/k7pl/actions/runs/38087621350), tête `70327a862f6738fd4e62de934e78e77fdf853a17`, a exécuté le script `scripts/ci/evaluate_spdx_negative_corpus.py` contre le document généré positif. Le rapport JSON est conservé dans l’artefact [k7pl-independent-spdx-validation-38087621350](https://github.com/AntheaLiles/k7pl/actions/runs/38087621350/artifacts/11682734460). L’étape est explicitement non bloquante et conserve les codes de retour / extraits de sortie du validateur direct et du wrapper.

| Sonde exploratoire | `pyspdxtools 0.8.5` direct | Wrapper K7PL | Observation |
|---|---|---|---|
| Contrôle positif généré | code 0 | `PASS` | Contrôle positif accepté par les deux chemins. |
| Namespace du document absent | code 1 | `FAIL` / `SPDX-TOOLS-VALIDATION` | Le validateur externe rejette cette mutation. |
| Version SPDX `SPDX-9.9` | code 1 | `FAIL` / `SPDX-TOOLS-VALIDATION` | Le validateur externe rejette cette mutation. |
| `downloadLocation` de paquet absent | code 1 | `FAIL` / `SPDX-TOOLS-VALIDATION` | Le validateur externe rejette cette mutation. |
| Expression de licence malformée | code 1 | `FAIL` / `SPDX-TOOLS-VALIDATION` | Le validateur externe rejette cette mutation. |
| Relation vers un identifiant absent | code 1 | `FAIL` / `SPDX-TOOLS-VALIDATION` | Le validateur externe rejette cette mutation. |
| `SPDXID` de paquet dupliqué | code 1 | `FAIL` / `SPDX-TOOLS-VALIDATION` | Le validateur externe rejette cette mutation. |
| Nom de paquet vide (issue amont #885) | **code 0** | `FAIL` / `SPDX-PREFLIGHT-PACKAGE-NAME` | La lacune connue est reproduite ; la garde locale intervient avant l’appel externe. |

Ce résultat confirme la nécessité de la garde locale pour le cas #885 et donne six signaux de rejet sur six autres mutations ciblées. Il ne mesure pas une couverture exhaustive du schéma SPDX, et un code retour non nul n'explique pas à lui seul toutes les règles validées. Les intentions des mutations restent à vérifier humainement contre la version normative SPDX 2.3 avant de transformer l'une d'elles en garde bloquante. L'étape ne modifie pas le résultat CI et ne constitue ni une validation indépendante exhaustive ni une attestation de conformité.
### Décision provisoire (go/no-go)

**GO pour maintenir et étudier le démonstrateur borné** dans cette PR de recherche : le noyau Lean vérifie un contrat explicite sur les champs normalisés ; un validateur externe hash-locké contrôle le document généré ; les résultats et empreintes sont conservés ; les cas négatifs connus sont testés.

**NO-GO pour le présenter comme porte de conformité de production ou comme preuve de conformité globale.** Le manifeste ne fournit que 14 entrées aplaties et ne prouve pas l'exhaustivité du SBOM ; le théorème ne prouve pas la correction du parseur ni celle du validateur tiers ; l'issue amont #885 reste un défaut connu traité par une garde locale ; la couverture de validation sur un corpus SPDX négatif élargi et la variabilité entre runs restent à mesurer. Aucune fusion ou publication n'est recommandée avant la fin de cette évaluation.

### Dépendances à figer avant généralisation

Les abstractions communes à tester en premier sont l'identité du composant, l'état explicite des champs inconnus, la provenance d'une observation, le modèle de relation et le schéma de rapport. Ne pas transformer ce premier contrat en méta-modèle universel tant que la comparaison avec un valideur indépendant et les cas négatifs n'ont pas été menés.

Les options de validation externe demandent une évaluation de leur version, de leurs dépendances et de leur intégrité avant ajout à la chaîne CI. Le simple fait qu'un outil se présente comme un validateur SPDX n'est pas une preuve suffisante pour l'épingler.

## 7. Rapport de couverture, limites et décisions d'extension — reprise du 11 octobre 2026

### État des preuves et séparation épistémique

Le présent audit se comprend comme une chaîne à cinq niveaux, qui ne peuvent pas être assimilés :

| Niveau | Ce qui est établi ou contrôlé | Ce qui ne découle pas du résultat |
|---|---|---|
| Prédicat formel | `verifyContract_sound` relie `verifyContract input = true` à `InventoryContract input`, pour un `AuditInput` Lean déjà construit. Les clauses vérifient l'identité déclarée, les champs normalisés, l'inventaire observé, les identifiants, les assertions `NOASSERTION` et les relations `DESCRIBES`. | Ni l'exhaustivité de la liste source, ni la vérité des observations, ni la conformité juridique/organisationnelle. La preuve est une propriété du prédicat et de son implémentation booléenne sur ce modèle. |
| Fidélité du parseur | `auditTexts` utilise `Lean.Json.parse`, puis projette un sous-ensemble de champs avec `parseAuditInput`. JSON malformé et champs requis absents/de mauvais type donnent une erreur contrôlée. | Le théorème n'établit pas que la projection est fidèle au document intégral, que tous les champs pertinents ont été lus, ni que le parseur est exempt de défauts. Une validation différentielle sur des entrées mutées reste utile. |
| Conformité du document au standard | Le document produit identifié par son SHA-256 a été accepté par `spdx-tools 0.8.5` dans la CI historique avec verrou hashé. | Le succès d'un validateur ne prouve pas qu'il soit exhaustif ou infaillible. Le défaut amont #885 est un contre-exemple connu ; les sondes ne remplacent pas une revue de la version normative SPDX 2.3. |
| Exhaustivité de l'inventaire | Le générateur extrait les 14 entrées présentes dans `lake-manifest.json`. La comparaison Lean détecte une divergence entre ces entrées représentées et les packages SPDX comparés. | Le manifeste aplati ne démontre pas qu'il contient chaque dépendance transitive, outil de build, artefact livré ou composant d'exécution. Aucune arête de dépendance n'est déduite et le SBOM n'est pas déclaré exhaustif. |
| Vérité externe / décision humaine | Les empreintes, versions et sorties CI identifient les objets effectivement traités ; des diagnostics et les résultats de sondes sont enregistrés comme observations. | Une URL ou licence ne devient pas vraie parce qu'elle est présente dans un fichier. L'intégrité, la provenance amont, la complétude des données, l'applicabilité d'une règle et les décisions de conformité doivent être justifiées indépendamment et validées par une personne responsable. |

Catégories de registre : une **source normative** est la version explicitement retenue de la spécification ; une **donnée calculée** est par exemple un SHA-256 ou une médiane calculée ; une **observation** est une sortie/un code de retour CI ; une **hypothèse** est une interprétation testable d'une mutation ; un **résultat de test** décrit les assertions réellement exécutées ; une **décision humaine** approuve une interprétation normative ou un seuil de blocage. Aucun de ces types ne doit être substitué silencieusement à un autre.

### Corpus négatif élargi et couverture diagnostique

Le corpus historique de sept mutations est conservé comme baseline, pas comme couverture SPDX générale. La branche de reprise ajoute un harness non bloquant comportant **17 mutations structurées** : namespace/version manquants ou incompatibles, version SPDX 2.2 face à une invocation 2.3, nom de document absent/vide, nom de package absent/null/vide, emplacement de téléchargement absent/vide, expression de licence malformée, assertion de licence syntactiquement plausible remplaçant `NOASSERTION`, cible/source de relation absente, ID de package dupliqué, relation dupliquée et cas de non-régression de l'issue amont #885. Deux cas de texte brut sont aussi soumis : JSON malformé et racine JSON qui n'est pas un objet. Des contrôles d'erreur de commande et d'absence du binaire sur `PATH` documentent les erreurs d'outillage.

L'affirmation `licenseDeclared = "MIT"` est délibérément une **assertion non étayée par le corpus**, pas une preuve que la licence réelle n'est pas MIT. Un validateur de syntaxe peut accepter cette chaîne ; seul un mécanisme distinct, alimenté par une source de vérité et une provenance contrôlables, pourrait vérifier la véracité de la déclaration. Cette distinction est importante pour éviter de confondre conformité de forme et exactitude factuelle.

Le premier run d'évaluation [#38118745654](https://github.com/AntheaLiles/k7pl/actions/runs/38118745654) a terminé le job Python avec succès et téléversé l'artefact [`k7pl-independent-spdx-validation-38118745654`](https://github.com/AntheaLiles/k7pl/actions/runs/38118745654/artifacts/11694647851), mais l'exécution complète a ensuite été **annulée** par un commit plus récent sur la branche. Ses données Python sont donc conservées comme mesure, pas comptées comme validation CI de bout en bout. Le second run [#38118879020](https://github.com/AntheaLiles/k7pl/actions/runs/38118879020) est, lui, terminé avec le statut **success** pour le workflow CI complet : contrôles rapides, Python, Lean et audits d'axiomes, TikZ, Verso, PDF, REUSE, commitlint et contrôles de sécurité ont réussi. Son artefact [`k7pl-independent-spdx-validation-38118879020`](https://github.com/AntheaLiles/k7pl/actions/runs/38118879020/artifacts/11694648121) est conservé.

Les deux rapports ont le même SHA-256 de SBOM positive (`a795763270df820df406f0f140cb352a469d636c6d7ec6f99447aef07fba161c)), les mêmes hashes des scripts de génération/validation/sondage/benchmark, du `lake-manifest.json`, du `lakefile.lean`, de `lean-toolchain` et de la fermeture hash-lockée, la même version effective `spdx-tools 0.8.5`, Python CPython 3.13.16 et runner `ubuntu24 / 20261004.327.1 / X64`. Chaque mesure contient cinq invocations de processus CLI indépendantes dans son job. Hashes clés identiques entre les deux artefacts :
- SBOM d'entrée : `a795763270df820df406f0f140cb352a469d636c6d7ec6f99447aef07fba161c`
- `validate_spdx.py` : `279ed992c4cf534539a27179cacefa998c35fee7e1cf2427e5268c95dad3fe03`
- générateur Lake→SPDX : `dbd9cdc4709a2b3d8a3d4dd46c17d6513437e06ac1f7567cecd52552271612f4`
- harness du corpus négatif : `0ae239b0c0d025ec64972a825d9043ee22bb95895c2a6e789b6a6cefceda5af8`
- benchmark : `28b270b277c41dece4ccbeac3a0b2d56c5b9d1e34c5ad26bde04ac7c59334bf9`
- fermeture des dépendances : `300e52cba5c20930dfd2e7a9a1ef6042d057e56336de6ae58c67ff14b0646632`
- manifeste Lake : `3325a9cb414e8e84e66b8f984f2c84928d439c33a7de4474b91fdd78e46a1ed0`
- `lakefile.lean` : `13fc7533fc9d725978473b02aeeebad4da03b771eabecf8cb23fa9a48a87b4d4`
- `lean-toolchain` : `8733782dc070a99b312039cda424f601b80f3be6f6f512627da5ba25adc27632`

| Mesure (ms) | Run #38118745654* | Run #38118879020 | Run #38119278580 | Run #38119675470 |
|---|---:|---:|---:|---:|
| Validateur `pyspdxtools`, médiane (min–max) | 242,982 (235,505–248,182) | 307,206 (301,649–312,112) | 318,769 (312,806–325,602) | 240,158 (233,308–244,312) |
| Wrapper, médiane (min–max) | 252,959 (245,874–258,674) | 319,455 (313,959–324,909) | 331,760 (325,818–338,511) | 250,105 (243,392–254,504) |
| Processus CLI complet, médiane (min–max) | 304,341 (299,104–316,036) | 382,304 (377,180–388,608) | 397,243 (389,657–402,530) | 302,761 (295,865–310,284) |
| Validation initiale unique, temps du sous-processus externe | 1 143,904 | 544,576 | 457,469 | non reporté |

* Le job Python du run #38118745654 a réussi et livré son artefact, mais le workflow global a été annulé après un commit ultérieur ; sa mesure est exploitable, mais ce run ne compte pas comme CI complète. Les trois workflows complets #38118879020, #38119278580 et #38119675470 ont terminé avec `success`, dont compilation/tests Lean, audits d'axiomes, validation SPDX indépendante, tests Python et builds Verso/PDF.

Les médianes augmentent du run #38118745654 au #38118879020 de **26,43 %** pour le validateur, **26,29 %** pour le wrapper et **25,62 %** pour le processus complet ; entre #38118879020 et #38119278580, elles augmentent respectivement de **3,76 %**, **3,85 %** et **3,91 %** ; entre #38119278580 et #38119675470, elles baissent de **24,66 %**, **24,61 %** et **23,78 %**. Sur les quatre jobs de mesure, les intervalles de médianes sont 240,158–318,769 ms, 250,105–331,760 ms et 302,761–397,243 ms. La dispersion interdit d'attribuer causalement les écarts au cache, à la charge CPU, au réseau ou au seul outil.

La décomposition des médianes aide à isoler les coûts observés : le validateur représente environ 80 % du temps médian de CLI. Pour #381188, #381192 et #381196, le wrapper ajoute respectivement 12,249 / 12,991 / 9,947 ms par rapport au validateur seul ; le processus complet ajoute respectivement 62,849 / 65,483 / 52,656 ms par rapport au wrapper. Ces différences décrivent des durées de commandes, sans identifier séparément chaque coût interne.

Les trois workflows complets #381188, #381192 et #381196 montrent la même version Python CPython 3.13.16, `spdx-tools 0.8.5`, l'image `ubuntu24 / 20261004.327.1 / X64`, le même hash d'entrée et les mêmes hashes de scripts, configuration Lean, manifeste et lock. La charge CPU effective du runner n'est pas enregistrée.

Le cache doit être distingué selon le job : les logs des runs complets #38118879020 et #38119278580 attestent un hit du cache GitHub Actions `lake-deps-e0afe00d1e73d08b1c131b31105a6363eda1755c2a87cdb6d3243da5453a5845` pour les dépendances Lake et un hit du cache Tectonic dans le job TikZ. Ces caches ne mesurent pas le sous-processus Python. Pour le job Python, aucun cache pip de `setup-python` n'est configuré et aucun indicateur hit/miss n'est exposé ; l'inventaire pip de 5,7 MB / 70 fichiers après installation n'indique pas à lui seul si les téléchargements sont venus d'un cache ou du réseau. La première validation unitaire est plus lente que les répétitions dans les trois runs (1 143,904 / 544,576 / 457,469 ms) ; c'est une observation compatible avec des différences d'initialisation/cache de processus, pas une estimation causale des effets du cache. Il serait incorrect d'attribuer les écarts au cache, à la charge CPU, au réseau ou au seul outil sans expérience contrôlée.

Résultat observé du corpus, identique sur les deux runs : 17 mutations structurées et deux cas de texte brut, plus le contrôle positif ; le validateur externe renvoie le code 0 dans cinq observations et un code non nul dans quinze. Le wrapper rapporte quatre `PASS`, quinze `FAIL` et un `ERROR`. Les identifiants de diagnostic rencontrés sont `SPDX-INPUT-JSON`, `SPDX-PREFLIGHT-DOCUMENT`, `SPDX-PREFLIGHT-PACKAGE-NAME` et `SPDX-TOOLS-VALIDATION`. Le contrôle d'erreur avec binaire absent du `PATH` produit `SPDX-VALIDATOR-CLI-MISSING` et le statut `ERROR` (code 2). Le cas #885 persiste : `pyspdxtools` renvoie 0 pour un package au nom vide alors que la prévalidation K7PL le rejette. Les erreurs de lancement simulées ne couvrent pas tous les crashes, timeouts, corruptions de base de données ou défauts internes possibles de l'outil.

Trois acceptations de mutations méritent des interprétations différentes :
- **Nom de document vide :** l'outil externe et le wrapper acceptent la chaîne vide, tandis que le standard SPDX 2.3 décrit le nom du document comme requis, cardinalité 1..1 et format texte sur une ligne ([clause 6.4](https://spdx.github.io/spdx-spec/v2.3/document-creation-information/)). Le tableau normatif ne fixe pas explicitement une longueur minimale ; conserver ce cas comme limite ou ambiguïté à qualifier, plutôt que comme non-conformité définitivement établie. L'absence du champ, distincte, est rejetée.
- **Assertion `licenseDeclared = "MIT"` :** l'outil accepte cette valeur syntaxiquement plausible. Ce résultat ne démontre ni que MIT est la vraie licence, ni que cette assertion est fausse : le validateur n'a pas de provenance/fait externe contre lequel la comparer. Le modèle Lean impose `NOASSERTION` pour ce démonstrateur ; cela ne prouve pas la vérité d'un fait externe.
- **Relation dupliquée :** l'outil accepte une relation répétée. La clause SPDX 2.3 des relations décrit une cardinalité générale de 0..* et n'impose pas une unicité globale ; ce n'est donc pas automatiquement un défaut standard. Cela viole cependant le profil local K7PL plus strict, qui demande une seule cible distincte `DESCRIBES` par package. Standard générique et profil local sont deux questions différentes.

Le nom de document vide est le candidat le plus net à une revue normative complémentaire ; l'assertion de licence montre une limite de vérité externe ; la relation répétée éprouve plutôt la différence entre les contraintes générales SPDX et le contrat de profil du prototype.



### Reproductibilité et interprétation des mesures

La comparaison historique #891 / #38086816755 porte sur deux runs indépendants du workflow mais cinq échantillons par run, même SHA d'entrée, même script de validation et même fichier de verrou. Les médianes historiques sont 304,564 ms puis 277,628 ms pour le sous-processus externe ; 316,976 puis 288,930 ms pour le wrapper ; 381,283 puis 345,772 ms pour le processus CLI. Il s'agit de différences descriptives, pas d'une estimation solide de performance. Les exécutions répétées sur un même runner partagent l'initialisation et des caches de fichiers potentiellement chauds ; la différence entre runs ne peut être attribuée à une cause à partir de ces mesures seules.

Le rapport de mesure amélioré relève pour chaque nouveau run les versions effectives Python et `spdx-tools`, l'identité disponible du runner, les empreintes SHA-256 du générateur, du manifeste, de `lakefile.lean`, du toolchain Lean, du script de benchmark, du script de validation, du corpus négatif et du lock de dépendances. Il inspecte aussi le cache pip disponible et explicite si un indicateur direct de cache GitHub est exposé. L'inventaire de `pip cache info` ne prouve pas un cache hit ni un état entièrement « froid » : cette distinction reste inscrite dans le rapport.

**Protocole et résultat de la mesure inter-run :** le seuil annoncé (au moins trois exécutions CI complètes, indépendantes, avec les mêmes empreintes d’entrée/scripts/lock et les mêmes versions effectives) est satisfait par #38118879020, #38119278580 et #38119675470. Le job Python de #38118745654 n’est pas compté comme workflow complet, car l’exécution a ensuite été annulée. Les temps individuels, min/médiane/max et les hashes communs sont détaillés dans le tableau ci-dessus. Les différences restent descriptives : ni la charge précise du runner ni un état de cache contrôlé ne permettent une attribution causale, et ces mesures ne constituent pas un benchmark généralisable à d’autres machines.

### Recommandation motivée sur les extensions

Les statuts ci-dessous sont des décisions de périmètre proposées, non la preuve qu'une intégration a été réalisée.

| Extension envisagée | Décision | Motif, alternative existante et critère de réouverture |
|---|---|---|
| **CycloneDX** | **NO-GO maintenant ; GO conditionnel si un consommateur réel l'exige** | Un export SPDX 2.3 et un validateur correspondant existent déjà. Ajouter un second générateur double la maintenance et risque des conversions avec perte. Réutiliser d'abord le générateur/SPDX et les schémas/validateurs CycloneDX officiels quand un consommateur, un champ requis et un flux interopérable sont identifiés. Lean pourrait vérifier un noyau d'invariants communs seulement après spécification explicite de ce noyau et tests différentiels contre le schéma retenu. [Spécification CycloneDX](https://cyclonedx.org/specification/overview/). |
| **OSV / SCA** | **GO pour garder le scanner et adaptateur externes ; NO-GO pour réimplémenter le moteur de vulnérabilités en Lean** | L'adaptateur `lake_manifest_to_osv.py` et l'intégration OSV-Scanner existent déjà. Un résultat sans avis n'est pas la preuve d'absence de vulnérabilité. Une couche Lean peut ultérieurement vérifier des politiques déclarées sur des résultats importés avec version/provenance, mais pas remplacer la base d'avis ou son matching. |
| **Syft / Grype** | **GO pour une évaluation comparative bornée sur un artefact effectivement livré ; NO-GO pour un remplaçant Lean** | Syft catalogue des sources/artefacts qu'il sait inspecter ; Grype analyse les composants/SBOM pour des vulnérabilités. Cette vue complète potentiellement le manifeste Lake, sans l'annuler ni prouver la complétude du manifeste. Comparer les écarts entre le manifeste, le SBOM d'artefact et les packages détectés. [Capacités SBOM](https://oss.anchore.com/docs/capabilities/sbom/) ; [cibles de scan Grype](https://oss.anchore.com/docs/guides/vulnerability/scan-targets/). |
| **ORT / licences et politiques** | **GO pour comparer l'outil existant si la décision de politique de licence est formulée ; NO-GO pour coder un moteur de licence Lean ad hoc** | ORT propose analyse, évaluation de règles/politiques et rapports. Tester un import SPDX ou un inventaire manuel, puis comparer les diagnostics aux mêmes entrées. Lean pourrait être utile pour prouver la cohérence d'une politique interne structurée, mais n'établirait pas la vérité juridique de l'étiquette ou l'applicabilité d'une licence. [ORT](https://github.com/oss-review-toolkit/ort) ; [configuration ORT](https://oss-review-toolkit.org/ort/docs/configuration/ort-yml). |
| **Fuzzing** | **GO pour un POC borné et non bloquant du parseur JSON Lean ; NO-GO comme porte bloquante immédiate** | Le corpus déterministe actuel n'est pas du fuzzing. Le [projet lean-fuzz](https://github.com/kiranandcode/lean-fuzz) expose un `FuzzTarget` personnalisé qui permet de viser `Lean.Json.parse` ; c'est le candidat naturel pour un petit POC épinglé sur un commit précis. Pour le wrapper Python, comparer aux outils établis [Hypothesis](https://github.com/HypothesisWorks/hypothesis) (génération de propriétés et réduction des cas) et [Atheris](https://github.com/google/atheris) (couverture guidée). Définir seeds, oracle, budget, reproduction/minimisation et corpus de régression avant tout branchement bloquant. Ne développer un moteur spécifique que si une lacune précise est mesurée. |
| **SAST Lean** | **NO-GO pour intégration ou porte bloquante ; GO conditionnel pour une étude de faisabilité** | [pc-sast-lean](https://github.com/dmbs335/pc-sast-lean) est un échafaudage de recherche de SAST à preuve portée, pas un scanner prêt pour la base K7PL ; son propre README indique que l'extraction depuis de vrais langages reste à venir et limite les résultats à une IR sémantique simplifiée. Il pourrait inspirer la vérification Lean de certificats produits par un scanner existant, si un cas d'usage précis et un corpus de défauts contrôlé sont identifiés. Compiler, `lake lint`, tester et auditer les axiomes restent complémentaires ; aucun de ces contrôles ni `actionlint`/`zizmor` ne prouve l'absence générale de vulnérabilités. |
| **WCAG / ARIA** | **NO-GO pour déclarer une conformité WCAG en Lean ; GO pour conserver les tests automatisés ciblés et compléter par une vérification humaine** | Les contrôles HTML/SVG présents vérifient des contrats précis mais ne couvrent pas l'ensemble de WCAG, l'expérience au clavier, les lecteurs d'écran ni le contexte d'usage. Réutiliser les tests automatiques, puis choisir une évaluation issue par issue (clavier, focus, nom/role/value, alternatives textuelles et tests assistifs) sur des artefacts rendus. Toute revendication de conformité demande une évaluation conforme aux règles W3C et un périmètre défini. [WCAG 2.2](https://www.w3.org/WAI/WCAG22/Understanding/conformance) ; [WAI-ARIA](https://www.w3.org/WAI/standards-guidelines/aria/). |

**Décision globale proposée : GO** pour maintenir le noyau de cohérence normalisée et réaliser un POC fuzzing non bloquant sur une frontière de parsing identifiée. **NO-GO** pour une porte de conformité en production, l'exhaustivité SBOM ou une affirmation de conformité légale/contractuelle/réglementaire de K7PL. **NO-GO** pour intégrer tout nouveau moteur généraliste sans comparaison préalable. La valeur spécifique attendue de Lean est une preuve locale utile sur des invariants/politiques précisément formalisés ou sur des certificats importés, pas la réimplémentation des validateurs de schéma, bases SCA, scanners de code ou évaluations d'accessibilité.

### Points de clôture et actions humaines restantes

La clôture de l'issue #122 est conditionnée à des runs du nouveau code terminés et comparables, à l'examen des observations du corpus par rapport à SPDX 2.3, à la synchronisation de ces résultats dans cette note et dans la section K du plan maître, et à une décision humaine sur la portée acceptable. Les sondes restent non bloquantes tant que les assertions ne sont pas qualifiées normativement. Avant fusion, la mainteneuse doit aussi examiner la PR, le run CI complet et les liens/artefacts. L'échec actuel du run CI de `main` sur Verso doit être traité séparément et ne doit pas être attribué au chantier K.

## 8. Références normatives et outils à vérifier à chaque évolution

- SPDX : spécification officielle et versions archivées — https://github.com/spdx/spdx-spec
- Outils officiels SPDX en Python — https://github.com/spdx/tools-python
- Outils officiels SPDX en Java — https://github.com/spdx/tools-java
- CycloneDX : spécifications et schémas — https://cyclonedx.org/specification/overview/
- WCAG 2.2, niveau de conformité et limites des tests — https://www.w3.org/WAI/WCAG22/Understanding/conformance
- WAI-ARIA — https://www.w3.org/WAI/standards-guidelines/aria/
- Lean Reference — https://lean-lang.org/doc/reference/latest/

La version du standard et du validateur doit être verrouillée explicitement dans le résultat d'un contrôle effectif ; ces liens ne constituent pas en eux-mêmes une preuve de validation.

## 9. Reprise complémentaire — 16 octobre 2026

### Défaut borné mis en évidence

Le contrat historique acceptait l’entrée normalisée où le manifeste Lake, la liste des paquets SPDX et les relations sont tous vides. Ce n’est pas une exigence générale du standard SPDX ; c’est une lacune du profil d’inventaire K7PL, dont le validateur existant `scripts/ci/check_manifest.py` exige déjà une liste `packages` non vide. L’interface CLI Lean étant directement appelable, le fait que le générateur en amont refuse habituellement le manifeste vide ne suffisait pas à garantir ce contrat à sa frontière.

La branche [`research/issue-122-contract-completeness-2026-10-16`](https://github.com/AntheaLiles/k7pl/tree/research/issue-122-contract-completeness-2026-10-16) ajoute au modèle et au vérificateur la condition « inventaire Lake non vide » et le diagnostic profil-spécifique `SBOM-EMPTY-INVENTORY`. Elle ajoute également `verifyContract_complete` et `verifyContract_iff_inventoryContract` pour exprimer la complétude et l’équivalence du vérificateur booléen avec le prédicat déclaré sur le modèle normalisé. Des tests Lean couvrent le théorème d’équivalence, l’entrée vide, son statut/diagnostic et les relations dupliquées ; le job CI inclut un test CLI avec code de sortie et JSON observés. Les nouveaux théorèmes et tests du changement de contrat ont été compilés/exécutés avec succès dans le workflow complet [#38953520978](https://github.com/AntheaLiles/k7pl/actions/runs/38953520978), pour la tête de PR `a70a92d995e87343c50fda9b23f7fc82248f7c42` : build de tous les modules Lean, build des tests, `lake test`, `lake lint`, audits d’axiomes (code et tests), tests Python, REUSE, contrôles sécurité, génération Verso et PDF et agrégat `CI OK` ont réussi. Le code de provenance ajouté ensuite au rapport du corpus (`v2`, identité de run/tête et hashes des scripts/configurations/locks) constitue un changement distinct : sa validation par une CI complète sur la tête plus récente reste à obtenir.

### Périmètre de preuve inchangé

L’équivalence formelle, si la compilation la confirme, ne porte que sur la correspondance entre le prédicat et le vérificateur appliqués à `AuditInput`. Elle ne prouve ni la fidélité de `parseAuditInput` aux octets JSON, ni la conformité intégrale SPDX, ni l’exhaustivité des dépendances, ni l’exactitude des assertions de licences, ni la provenance authentique des révisions. Les tests de parseur et l’acceptation par `spdx-tools 0.8.5` restent des preuves indépendantes, chacune de portée plus étroite. Le corpus négatif reste exploratoire et non bloquant tant que son oracle normatif n’a pas été validé humainement.

La matrice détaillée des sondes et de leurs observations est dans [`SPDX-NEGATIVE-CORPUS-REVIEW.md`](SPDX-NEGATIVE-CORPUS-REVIEW.md). La prochaine décision demeure humaine : examiner le diff final et sa CI, qualifier l’ambiguïté du nom de document vide selon SPDX 2.3 et ratifier la frontière entre le standard générique et le profil K7PL. Le rapport du corpus inclut maintenant en code v2 les identifiants de workflow, le SHA testé, la tête de PR et les empreintes de scripts/configurations/locks ; il faut vérifier ces champs dans le prochain artefact avant de considérer la correction de provenance validée. L’issue #122 reste ouverte ; aucun changement n’est apporté à `spec/` ni à la sémantique normative K7PL.
