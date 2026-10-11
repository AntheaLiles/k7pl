<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# L1 — Décisions et analyses spécifiques

**État :** IN PROGRESS  
**Périmètre :** migration sémantique de `docs/suivi/`  
**Objet :** convertir les arbitrages historiques en critères scientifiques et en actions traçables, sans promouvoir prématurément leur contenu dans la spécification normative.

Ce document complète [L1-SUIVI.md](L1-SUIVI.md). Il ne remplace ni la spécification, ni les documents d'architecture, de méthode ou d'assurance. Une décision y décrite comme retenue correspond à l'état de migration arrêté ; sa traduction normative ou formelle reste une action distincte lorsqu'elle n'est pas encore réalisée.

## 1. Rejeu et reproductibilité — ARB-PR-04

### Décision

La revendication générale de rejeu bit-à-bit est abandonnée comme propriété sémantique générale de K7PL.

La reproductibilité est formulée relativement à un profil d'exécution `Π`. Le profil doit permettre de distinguer au minimum :

- la version de la spécification et du langage ;
- la représentation/formalisation concernée ;
- l'implémentation ou la chaîne d'exécution ;
- l'architecture et les paramètres matériels pertinents ;
- les paramètres d'exécution ;
- les sources de non-déterminisme pertinentes.

Le bit-à-bit peut rester une propriété expérimentale d'une chaîne concrète lorsqu'elle est effectivement établie. Il ne constitue pas une obligation sémantique universelle du langage.

### Portée scientifique

Cette distinction sépare :

1. la reproductibilité computationnelle d'un résultat ou d'une trace ;
2. le déterminisme sémantique lorsqu'il est défini ;
3. l'identité binaire d'un artefact ou d'une exécution particulière.

Elle évite de faire porter à la sémantique une propriété qui dépend de toute la chaîne matérielle et logicielle.

### Actions

1. Remplacer la formulation historique d'ARB-PR-04 par cette distinction dans le registre de migration.
2. Vérifier la cohérence de la définition de `E_repro` et du profil `Π` avec cette portée.
3. Tracer la revendication retenue vers `ASSURANCE.md`, sans déclarer la propriété établie avant production de l'évidence correspondante.
4. Conserver la promesse bit-à-bit historique comme provenance, non comme engagement normatif.

**État :** DÉCISION ARRÊTÉE ; FORMALISATION À EFFECTUER.

## 2. Imports théoriques ciblés

Les imports ne doivent pas être traités comme un bloc homogène. Le statut est désormais déterminé par le rôle effectivement joué dans la cohérence du projet.

| Élément | Statut retenu | Rôle | Travail requis |
|---|---|---|---|
| Théorie des modes | **NORMATIF** | Fondation normative reliant les composantes modales du langage | Démontrer la cohérence inter-composantes et expliciter les dépendances |
| Théorie des types graduée formalisée | **NORMATIF** | Fondation normative reliant les grades, les usages et les obligations de typage | Démontrer la cohérence inter-composantes et établir la correspondance avec la formalisation |
| Calf/Decalf | **DÉPENDANCE FORMELLE** | Mécanisme de construction utilisé pour obtenir certaines structures formelles | Décrire précisément ce qui est construit avec lui et ce qui ne devient pas pour autant normatif |
| Récursion gardée multi-horloges | **DÉPENDANCE FORMELLE**, à qualifier par sédimentation | Mécanisme temporel dont le statut et les obligations diffèrent selon les couches | Produire une analyse séparée pour les couches 1, 2 et 3 |

### 2.1 Théorie des modes

La théorie des modes n'est pas un simple support bibliographique. Elle doit être traitée comme une composante normative dont la fonction est de relier plusieurs parties du système.

Le travail attendu n'est donc pas seulement de « verser un import » dans la spécification. Il faut établir une chaîne de cohérence montrant comment les notions modales interviennent conjointement dans :

- les jugements ;
- les règles de typage ;
- les usages/ressources concernés ;
- les constructions dépendantes ;
- les propriétés de préservation ou de cohérence qui leur correspondent ;
- leur représentation formelle ;
- les preuves et tests qui constituent l'évidence associée.

Le critère d'achèvement est une démonstration de cohérence inter-composantes, et non la seule présence d'une définition importée.

### 2.2 Théorie des types graduée formalisée

La théorie des types graduée formalisée possède le même statut normatif. Elle doit donc être reconstruite comme une dépendance conceptuelle de bout en bout.

Le travail doit notamment distinguer :

- les notions graduées qui sont constitutives du langage ;
- les règles qui les propagent ;
- les obligations mathématiques qu'elles imposent ;
- la formalisation Lean correspondante ;
- les propriétés qui doivent être démontrées pour justifier la cohérence de la chaîne.

La formalisation existante ne vaut pas, à elle seule, démonstration que toutes les composantes normatives du langage sont cohérentes avec cette théorie. Cette correspondance doit être construite explicitement.

### 2.3 Calf/Decalf

Calf/Decalf ne doit pas être promu au même niveau normatif. Il constitue un mécanisme de construction.

Le travail consiste à établir une frontière explicite entre :

- les objets ou propriétés de K7PL qui sont normatifs ;
- les constructions obtenues au moyen de Calf/Decalf ;
- les résultats formels qui dépendent de ce mécanisme ;
- les éventuelles hypothèses importées avec le mécanisme.

Le mécanisme peut être indispensable à la construction d'une formalisation sans devenir une composante normative de K7PL.

### 2.4 Récursion gardée multi-horloges

La récursion gardée multi-horloges doit être analysée par sédimentation. Une qualification globale serait trop grossière.

Le chantier doit produire trois analyses distinctes :

| Couche | Question directrice |
|---|---|
| Couche 1 | Quelle structure temporelle minimale est normative et quelles obligations de récursion lui sont propres ? |
| Couche 2 | Quelles structures supplémentaires de communication/concurrence utilisent ou transforment la discipline temporelle ? |
| Couche 3 | Quelles constructions de niveau supérieur réutilisent cette discipline et quelles nouvelles obligations apparaissent ? |

Le résultat attendu est une carte « couche → mécanisme → obligation → preuve/formalisation », et non une simple citation de la littérature sur la récursion gardée.

**État global :** DÉCISION ARRÊTÉE ; ANALYSE FORMELLE À CONDUIRE.

## 3. `when` et diamant temporel

### Décision

La voie retenue est l'introduction de la structure supplémentaire correspondant à l'option A de l'arbitrage historique.

La complexité de cette solution n'est pas un motif de réduction du périmètre. Le principe architectural de K7PL est au contraire de sédimenter la complexité jusqu'à obtenir un modèle cohérent et globalement compréhensible.

L'existence éventuelle d'une restriction locale suffisante de `when` reste une question de sédimentation et de preuve, mais elle ne constitue plus un critère permettant d'écarter la structure supplémentaire.

### Conséquence

La question « une restriction locale suffit-elle ? » devient une question de couche :

- déterminer à quelle couche l'information manquante apparaît ;
- identifier la structure qui doit la porter ;
- formuler les règles correspondantes ;
- vérifier que les invariants nécessaires sont restaurés ;
- établir les obligations de préservation.

Il ne faut donc pas transformer cette recherche en alternative éditoriale entre « simplifier » et « ajouter ». La structure est retenue ; la sédimentation détermine où et comment elle apparaît.

**État :** DÉCISION ARRÊTÉE ; SÉDIMENTATION ET PREUVES À CONDUIRE.

**Clarification et décision d'autrice du 11 octobre 2026.** L'« option A » de cette section désigne le choix architectural de conserver la structure temporelle supplémentaire ; elle ne doit pas être confondue avec la « lecture A » de la séance 55 sur le budget. L'autrice a ratifié P3-B : `When` est un déclencheur réactif ; l'attente d'un événement relève de l'orchestrateur et non du coût d'exécution de l'automate déclenché. La décision fixe cette frontière conceptuelle, mais ne choisit pas encore la représentation mathématique de la latence ni les signatures de `ψ`/`Adm`/`Consume`. La preuve de correction de ressource, la formalisation de l'orchestration et la résolution du domaine de `Cost_Budget` restent ouvertes ; la porte C n'est pas close.

## 4. T-68 — minimalité des 44 primitives

T-68 constitue désormais un chantier scientifique autonome et bloquant pour l'étape d'implémentation/mécanisation.

La question n'est pas de stabiliser une liste de noms. Il faut démontrer que chaque primitive conservée correspond à une obligation que les constructions disponibles ne permettent pas de satisfaire sans réintroduire une primitive de même niveau.

Le critère de minimalité retenu est donc :

> Une primitive est minimale si aucune factorisation ou dérivation disponible ne préserve l'ensemble de ses obligations normatives et formelles sans introduire une autre primitive de même niveau.

L'analyse doit distinguer au minimum :

- primitive conceptuelle ;
- primitive syntaxique ;
- primitive formelle ;
- primitive d'implémentation.

La similarité de forme ou de notation ne constitue jamais un critère suffisant de factorisation. Les sept factorisations refusées constituent une base de contre-exemples et de critères négatifs ; elles doivent être réutilisées dans l'audit T-68.

Pour chaque primitive, le dossier final devra pouvoir relier :

`primitive → obligation → règle → propriété → preuve`

et, lorsqu'une factorisation a été examinée :

`primitive → factorisation candidate → obligation perdue ou conservée → décision`.

### Gate

T-68 doit être suffisamment établi avant :

- la stabilisation de l'implémentation du noyau ;
- la mécanisation systématique correspondante ;
- toute conclusion de minimalité du langage.

Cela ne signifie pas qu'aucun prototype exploratoire ne puisse exister ; cela signifie qu'un prototype ne doit pas être pris comme fondement d'une architecture normative encore non stabilisée.

**État :** CHANTIER MAJEUR ; BLOQUANT POUR LA STABILISATION DE L'IMPLÉMENTATION ET DE LA MÉCANISATION.

## 5. Annexes B, C et D — D-7 reste ouvert

### État établi, et non décision normative

L'arbre `main` observé au 2026-10-11 (`86959948ff36deb6e8ee0985cf22740787696720`) importe `AnnexeA` dans `spec/Spec.lean` et ne contient pas de modules `spec/Spec/AnnexeB.lean`, `AnnexeC.lean` ou `AnnexeD.lean`. Les prototypes sont conservés dans `tooling/prototypes-bcd/`, les sources Org dans `docs/archives/manuscrit-org/`. La séparation physique actuelle est donc un fait ; elle ne prouve pas que l'autrice ait ratifié le périmètre éditorial.

Le registre central [`docs/tracking/DECISIONS.md`](../tracking/DECISIONS.md) garde D-7 ouvert. L'affirmation antérieure de ce dossier (« DÉCISION ARRÊTÉE ») était trop forte et doit être lue comme une proposition d'analyse historique, non comme une décision d'autrice. Aucun texte normatif ne doit être changé pour rationaliser a posteriori ce retrait.

Les options, avec conséquences et sources, sont comparées dans [`L1-ANNEXES-EXTRACTION.md`](L1-ANNEXES-EXTRACTION.md). Pour choisir sans refaire l'analyse :

| Choix | Effet | Coût/risque principal |
|---|---|---|
| **A — développer séparément** | trois annexes, chacune avec statut réel de l'outil, interfaces, preuves/tests et dépendances | maintenance triple et obligations de vérification par outil |
| **B — regrouper** | une annexe « Outillage complémentaire » explicitement non normative, avec trois sous-sections | réécriture des renvois ; risque de suggérer que les prototypes sont implémentés |
| **C — différer** | garder le Verso normatif sur A seule et conserver B/C/D comme sources/prototypes hors norme | moindre visibilité de l'intention historique ; il faut expliciter la frontière |

Le rendu actuel ressemble factuellement à C ; ce constat ne vaut pas ratification de C. L'autrice doit choisir A, B ou C avant toute modification normative.

### Conséquence méthodologique

La qualification doit séparer : (1) les propriétés déjà décrites dans le corps normatif ; (2) les mécanismes seulement utilisés par les prototypes ; (3) les formats, commandes et politiques propres à ces prototypes ; (4) les hypothèses ou garanties non démontrées. La présence d'un concept dans un prototype ne le rend pas normatif, et la présence d'une description dans une ancienne annexe n'établit pas qu'un outil existe.

### Action autorisée avant arbitrage

- Conserver les sources historiques et les prototypes existants avec leur provenance.
- Vérifier et corriger les registres, liens et affirmations de statut.
- Ne pas restaurer/effacer les annexes de `spec/` ni réécrire des propositions normatives avant décision explicite.
- Après le choix d'auteur, mettre à jour les documents de suivi concernés et les critères L1 ; toute réécriture normative ultérieure doit être une modification distincte et traçable.

**État :** ANALYSE COMPARATIVE PRÉPARÉE ; DÉCISION D'AUTEUR REQUISE.

## 6. Synthèse des décisions arrêtées

| Point | Décision | Prochaine preuve/action | Bloquant |
|---|---|---|---|
| ARB-PR-04 | Reproductibilité paramétrée par `Π`, pas de rejeu bit-à-bit général | Formaliser `Π` et `E_repro`, puis assurer la traçabilité | Non |
| Imports | Modes + types gradués = NORMATIF ; Calf/Decalf = DÉPENDANCE FORMELLE ; récursion gardée multi-horloges = qualification par couche | Construire les chaînes de cohérence et la sédimentation | Oui pour la clôture théorique |
| `when` | Structure temporelle supplémentaire retenue ; distincte de la lecture budgétaire A/B de la séance 55 | Sédimenter par couche et prouver le contrat When → effet non borné → ψ/Adm/Consume ; ratifier P3 si nécessaire | Oui pour la formalisation temporelle et la clôture C |
| T-68 | Audit autonome de minimalité des 44 primitives | Primitive → obligation → règle → propriété → preuve | **Oui : implémentation/mécanisation** |
| Annexes B/C/D | Sortie de la spécification ; branche outillage séparée ; pas stdlib par défaut | Extraire les renvois et créer la frontière d'outillage | Oui pour la cohérence normative |

## 7. Décisions restant ouvertes

Les analyses techniques ci-dessus ne remplacent pas les décisions réservées à l'autrice. En particulier, D-7/ANOM-04 reste ouvert. Les autres décisions et preuves scientifiques conservent leur propre statut ; aucun état fermé n'est inféré depuis un compte rendu historique sans provenance.

## 8. Fiches courtes pour arbitrage

### D-7 / ANOM-04 — périmètre des prototypes B, C et D

- **A — développer séparément :** conserver trois annexes à l'avenir, en vérifiant le statut réel de chaque outil et toutes les garanties annoncées.
- **B — regrouper :** une annexe « Outillage complémentaire » avec les trois prototypes, et une frontière explicite entre langage spécifié et outils.
- **C — différer :** garder le document normatif sur A seule jusqu'à implémentation vérifiable, avec provenance dans `tooling/prototypes-bcd/` et `docs/archives/manuscrit-org/`.

Effet commun : aucune modification du contenu normatif n'est proposée dans cette PR. Choisir une option et l'inscrire explicitement dans D-7 est nécessaire pour clôturer ANOM-04.

### D-9 / ANOM-09 — index paginé

- **État de départ mesuré :** le PDF de `main` au SHA `86959948` avait une liste statique de 31 termes sans pages, visible pages 277–278.
- **Voie technique testée dans cette branche :** réutiliser l'extension existante `SpecExt.printindex`, qui agrège les marques automatiques issues de `IndexTerms.lean` et émet des références de pages en TeX ; les liens HTML sont des liens de sections. Le résultat doit être contrôlé dans le PDF réellement construit, pas uniquement par compilation.
- **Preuve observée :** sur la candidate `9c34e7aaa99e00809c00d56812ab2160b55c276d`, run [`38131422345`](https://github.com/AntheaLiles/k7pl/actions/runs/38131422345) terminé avec `success`; `spec-pdf` (`11699506098`) contient 287 pages et un index paginé aux pages imprimées 277–278. `ordonnancement` mène à `64, 82, 99, 171, 175, 233`; les cadres rouges hyperref ont disparu au rendu; le journal `spec-pdf-log` (`11699366281`) ne contient pas de cibles `idx-*` non résolues, et la garde CI dédiée a réussi. **État : techniquement résolu sur cette candidate.**

### D-10 / ANOM-10 — interface HTML localisée

- **Configurable dans le dépôt :** `tools/SpecExt/Translate.lean` remplace une liste explicite de chaînes HTML/JS après génération ; `tools/SpecMain.lean` déclenche cette passe ; `tests/SpecToolsTest.lean` teste des cas unitaires. Cela établit une localisation partielle contrôlée par le dépôt, pas une interface entièrement traduite.
- **Dépend de l'amont :** les chaînes de navigation et de recherche sont émises par Verso v4.34.0 (par ex. `VersoManual.lean` et `static-web/search/search-box.js`). La configuration `HtmlConfig` consultée expose les options de table des matières mais aucune option de locale/localisation n'a été trouvée. Le remplacement local peut casser en cas de modification des chaînes.
- **Proposition upstream préparée, non soumise :**

  **Titre :** `Add configurable locale/i18n for Verso manual UI and search`

  **Problème observé :** K7PL doit remplacer des chaînes après génération ; dans Verso v4.34.0, `HtmlConfig` n'expose pas de locale, tandis que `VersoManual.lean`, `static-web/search/search-box.js` et `search-page.js` émettent des chaînes UI en dur.

  **Demande :** exposer un catalogue centralisé de messages UI (navigation, recherche, compteurs, états vides, libellés ARIA, titres utilitaires) avec locale de repli documentée et exemple `fr`.

  **Critères d'acceptation proposés :** les chaînes visibles/accessibilité relèvent du catalogue ; le repli des clés absentes est déterministe ; tests de page de recherche, suggestions, résultats vides, compteurs et titres ; locale ou fournisseur de messages configurable depuis `HtmlConfig`.

  **État :** fiche prête pour révision humaine ; ticket non soumis et aucune réponse upstream connue.
- **Critère de clôture :** couverture des chaînes dans le rendu HTML réel documentée ; les chaînes hors du contrôle local restent ouvertes jusqu'à une capacité upstream ou à une autre stratégie explicitement choisie.

## 9. Provenance

Sources principales de la migration :

- [`docs/tracking/DECISIONS.md`](../tracking/DECISIONS.md) — arbitrages et décisions historiques ;
- [`docs/tracking/primitives.md`](../tracking/primitives.md) — inventaire et justification lexicale des primitives ;
- [`docs/tracking/factorisations-refusees.md`](../tracking/factorisations-refusees.md) — contre-exemples aux factorisations ;
- [`docs/tracking/hypotheses-de-module.md`](../tracking/hypotheses-de-module.md) — hypothèses de formalisation et obstacles ;
- [`docs/tracking/ANOMALIES.md`](../tracking/ANOMALIES.md) — état des anomalies de conversion et des annexes.

Les formulations de ce document sont une qualification de migration. Elles ne valent pas preuve mathématique des propriétés qu'elles prescrivent de démontrer.
