<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Chantier K — Assurance de conformité outillée avec Lean 4

**État au 2026-10-10 :** la tête de PR `69368cea93b9c0fc25d2164b8052e90a85e1690a` a passé tous les jobs du [run CI #891](https://github.com/AntheaLiles/k7pl/actions/runs/38063142568). Le run couvre la compilation Lean, l'audit des 14 entrées Lake, les cas CLI négatifs, `lake test`, `lake lint`, les audits d'axiomes, les contrôles sécurité/REUSE et le build Verso/PDF. `spdx-tools 0.8.5`, installé depuis une fermeture de dépendances hash-lockée, valide la sortie SPDX 2.3. Cinq invocations répétées sur le même SHA-256 ont produit `PASS`, avec un rapport min/médiane/max téléversé. L'évaluation sur plusieurs runs indépendants, la couverture élargie et toute revendication d'exhaustivité restent ouvertes ; aucune conformité globale ou préparation à la production n'est affirmée.

## 1. Objet et décisions antérieures récupérées

L'issue [#122](https://github.com/AntheaLiles/k7pl/issues/122) ouvre une recherche sur le rôle de Lean dans l'assurance de conformité. Elle n'autorise ni une modification de la spécification normative de K7PL, ni une modification sémantique de son implémentation. Elle exige de distinguer règles formalisées, traçabilité, preuves, résultats empiriques et décision humaine.

La [PR #121](https://github.com/AntheaLiles/k7pl/pull/121) est fusionnée. Elle sépare ce chantier de la campagne OpenSSF, mise en pause. Le présent document ne rouvre pas cette campagne et ne transforme pas son état en conformité vérifiée.

Les décisions antérieures récupérables dans le dépôt sont les suivantes :

- `docs/security/LEAN-SECURITY-TOOLCHAIN.md` propose un modèle interne indépendant des formats, des adaptateurs d'entrée et de sortie, des règles formelles bornées, ainsi que des validations indépendantes des documents exportés.
- `docs/security/TOOLING-EVALUATION.md` propose OSV-Scanner pour le premier scan SCA, maintient la SBOM comme sujet distinct, identifie Syft/Grype/ORT comme candidats à évaluer, et exige une évaluation contrôlée du SAST Lean.
- La [PR #113](https://github.com/AntheaLiles/k7pl/pull/113) a livré un générateur SPDX 2.3 pour l'inventaire borné aux entrées de `lake-manifest.json`. Il préserve les URL et révisions de commits, utilise `NOASSERTION` pour les informations de licence et de copyright inconnues, n'invente pas d'arêtes de dépendance et dispose de tests hors ligne.
- Le même historique indique que la sortie SPDX n'a pas été validée par un parseur indépendant. Aucun choix final d'implémentation native en Lean n'est établi.

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

| Lot | État | Critère de sortie |
|---|---|---|
| A — inventaire et récupération des décisions | **Exploré** | Sources repérées ; limites et décisions non récupérables explicites |
| B — faisabilité et architecture | **Conçu** | Matrice et frontières ci-dessus documentées |
| C — contrat SPDX minimal | **Conçu** | Invariants du modèle normalisé explicités |
| D — prototype Lean/CLI/tests | **Testé en CI (#891)** | Compilation, audit d'inventaire, tests positifs/négatifs, lint, audits d'axiomes et artefacts de preuve validés sur la tête de PR `69368cea93b9c0fc25d2164b8052e90a85e1690a` |
| E — validation SPDX indépendante | **Intégration expérimentale réussie en CI (#891)** | Document précis accepté par `spdx-tools 0.8.5`, fermeture hash-lockée et garde pour l'issue amont #885 ; d'autres limites sont possibles |
| F — évaluation | **Baseline intra-run acquise ; évaluation inter-run ouverte** | Répéter sur des runs indépendants, tester un corpus négatif SPDX élargi et mesurer la couverture de validation et les diagnostics |
| Extension SCA/SAST/CycloneDX/WCAG | **À prioriser après évaluation** | Décision fondée sur le prototype, le bénéfice et les dépendances communes |

### Évaluation empirique : baseline et micro-mesure

Les métadonnées du run CI #877 enregistrent environ 5 min 46 s pour le workflow complet, 4 min 56 s pour le job Lean, 2 min 21 s pour l'étape `lake test` et 18 s pour le job Python. Ces durées de CI incluent installation, cache, initialisation et contrôles annexes ; elles ne mesurent pas isolément le validateur.

Le run #887 a mesuré une première invocation de validation à 543,202 ms pour le sous-processus `pyspdxtools` et 556,297 ms pour le wrapper. Dans le run #891, l'invocation autonome préalable aux répétitions a pris 496,043 ms pour `pyspdxtools` et 508,578 ms pour le wrapper. Les cinq invocations suivantes, exécutées séparément sur le même runner et sur le même document, ont toutes renvoyé `PASS`, sans diagnostic, avec le même SHA-256 `a795763270df820df406f0f140cb352a469d636c6d7ec6f99447aef07fba161c`.

| Mesure sur les cinq répétitions du run #891 | Min. | Médiane | Max. |
|---|---:|---:|---:|
| Processus CLI complet, démarrage Python inclus | 378,237 ms | 381,283 ms | 389,103 ms |
| Wrapper `validate_spdx.py` (après imports) | 314,895 ms | 316,976 ms | 325,656 ms |
| Sous-processus `pyspdxtools` seul | 302,409 ms | 304,564 ms | 313,096 ms |

Le rapport d'évidence enregistre aussi la version Python 3.13.16, la plateforme du runner, le SHA-256 du script de validation et celui du fichier de verrouillage. L'écart entre les invocations autonomes et les répétitions suivantes est notable ; un effet de caches ou des conditions d'exécution différentes est plausible, mais ces données ne permettent pas d'en attribuer la cause. Cinq répétitions d'un seul job constituent une micro-mesure descriptive, pas un benchmark multi-machine ni une estimation robuste de variance.

La CI produit désormais les durées monotones dans le rapport et le résumé de job ; une fixture CLI vérifie l'égalité **octet pour octet** de deux sorties du générateur pour le même manifeste, le même toolchain et un horodatage fixé. L'étape suivante reste de répéter la mesure dans des runs indépendants et d'élargir le corpus négatif pour caractériser couverture, diagnostics et limites du validateur.

### Décision provisoire (go/no-go)

**GO pour maintenir et étudier le démonstrateur borné** dans cette PR de recherche : le noyau Lean vérifie un contrat explicite sur les champs normalisés ; un validateur externe hash-locké contrôle le document généré ; les résultats et empreintes sont conservés ; les cas négatifs connus sont testés.

**NO-GO pour le présenter comme porte de conformité de production ou comme preuve de conformité globale.** Le manifeste ne fournit que 14 entrées aplaties et ne prouve pas l'exhaustivité du SBOM ; le théorème ne prouve pas la correction du parseur ni celle du validateur tiers ; l'issue amont #885 reste un défaut connu traité par une garde locale ; la couverture de validation sur un corpus SPDX négatif élargi et la variabilité entre runs restent à mesurer. Aucune fusion ou publication n'est recommandée avant la fin de cette évaluation.

### Dépendances à figer avant généralisation

Les abstractions communes à tester en premier sont l'identité du composant, l'état explicite des champs inconnus, la provenance d'une observation, le modèle de relation et le schéma de rapport. Ne pas transformer ce premier contrat en méta-modèle universel tant que la comparaison avec un valideur indépendant et les cas négatifs n'ont pas été menés.

Les options de validation externe demandent une évaluation de leur version, de leurs dépendances et de leur intégrité avant ajout à la chaîne CI. Le simple fait qu'un outil se présente comme un validateur SPDX n'est pas une preuve suffisante pour l'épingler.

## 7. Références normatives et outils à vérifier à chaque évolution

- SPDX : spécification officielle et versions archivées — https://github.com/spdx/spdx-spec
- Outils officiels SPDX en Python — https://github.com/spdx/tools-python
- Outils officiels SPDX en Java — https://github.com/spdx/tools-java
- CycloneDX : spécifications et schémas — https://cyclonedx.org/specification/overview/
- WCAG 2.2, niveau de conformité et limites des tests — https://www.w3.org/WAI/WCAG22/Understanding/conformance
- WAI-ARIA — https://www.w3.org/WAI/standards-guidelines/aria/
- Lean Reference — https://lean-lang.org/doc/reference/latest/

La version du standard et du validateur doit être verrouillée explicitement dans le résultat d'un contrôle effectif ; ces liens ne constituent pas en eux-mêmes une preuve de validation.
