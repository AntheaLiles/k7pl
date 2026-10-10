<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Chantier K — Assurance de conformité outillée avec Lean 4

**État au 2026-10-10 :** inventaire documentaire réalisé ; choix d'un démonstrateur borné ; prototype sur branche dédiée ; validation CI distante à observer. Aucune décision de production ni revendication globale de conformité.

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
| SPDX | `scripts/ci/lake_manifest_to_spdx.py`, `test_lake_manifest_to_spdx.py` | Inventaire limité au manifeste Lake ; parseur SPDX indépendant non encore intégré |
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

Pour la première version, le rapport du prototype enregistre les chemins et le périmètre mais pas encore les empreintes SHA-256 des entrées. Cette limite interdit de le considérer comme un contrat de provenance complet.

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

La CI compile la bibliothèque et le CLI, exécute le générateur actuel sur le vrai manifeste, lance l'audit sur le document généré et vérifie le statut du rapport JSON. Cette exécution teste l'intégration dans le dépôt ; elle ne remplace pas le validateur SPDX indépendant, encore à intégrer.

### Critères d'acceptation

- tous les modules Lean du prototype sont effectivement compilés par la cible déclarée ;
- tests positifs et négatifs réussis ;
- rapport JSON stable dans sa structure, avec statut exploitable et diagnostics identifiables ;
- comportement CLI distinct pour succès, non-conformité au contrat et entrée malformée/illisible ;
- génération déterministe pour un manifeste et un horodatage donnés ;
- validation indépendante de SPDX 2.3 par un outil versionné et vérifié, **condition encore ouverte** ;
- pas de modification de la spécification normative ou de la sémantique de K7PL ;
- la CI et une revue du diff passent avant que le prototype soit annoncé comme testé.

## 6. Séquencement et statuts

| Lot | État | Critère de sortie |
|---|---|---|
| A — inventaire et récupération des décisions | **Exploré** | Sources repérées ; limites et décisions non récupérables explicites |
| B — faisabilité et architecture | **Conçu** | Matrice et frontières ci-dessus documentées |
| C — contrat SPDX minimal | **Conçu** | Invariants du modèle normalisé explicités |
| D — prototype Lean/CLI/tests | **Prototypé, vérification CI en attente** | Compilation, tests et exécution sur le manifeste réel passent |
| E — validation SPDX indépendante | **Ouvert** | Validateur, version et chaîne d'approvisionnement acceptables ; succès sur la sortie effective |
| F — évaluation | **Non commencé** | Couverture mesurée, rapports différentiels, temps d'exécution et limites observées |
| Extension SCA/SAST/CycloneDX/WCAG | **À prioriser après évaluation** | Décision fondée sur le prototype, le bénéfice et les dépendances communes |

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
