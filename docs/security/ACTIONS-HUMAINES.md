<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Actions humaines — clôture OpenSSF et recette de navigation

| | |
|---|---|
| État | **À poursuivre** : la PR [#129](https://github.com/AntheaLiles/k7pl/pull/129) est fusionnée ; l'exploitation du workflow Security, les décisions et les validations humaines restent ouvertes. |
| Profil externe | [K7PL sur Best Practices](https://www.bestpractices.dev/en/projects/15239/baseline-2) — dernier état vérifié le 2026-10-10 : in_progress, baseline v2026.08.28, métadonnées de nom, description, licence et langages vides. |
| Mode d'emploi | Suivre les phases dans l'ordre. Ne cocher une case qu'après observation effective ; inscrire la preuve, la date et la décision dans le registre approprié. |
| Registres | [État opérationnel](OPENSSF-ROADMAP.md) · [Décisions D1–D11](DECISIONS-REQUISES.md) · [Analyse BadgeApp](BADGE-AUTOMATION.md) · [Matrice des critères](BADGE-CONFORMANCE-MATRIX.md) |

Les sections 0 à 5 concernent la clôture OpenSSF. La section 6 est un volet distinct consacré à la recette humaine du premier chantier de navigation interactive, regroupé ici à la demande de la mainteneuse pour disposer d'une checklist d'actions humaines unique. Cette liste est centrée sur les gestes, décisions et preuves qui exigent la mainteneuse. Les cases de la matrice ne sont pas des réponses enregistrées sur BadgeApp. Les rapports d'agents ne constituent pas une revue de sécurité humaine. La réussite de la CI ne prouve ni un réglage administrateur ni une publication de bout en bout.

## 0. Valider puis intégrer le socle

- [x] **Socle automatisé intégré** : PR #129 fusionnée le 2026-10-10 à 17:09:57 UTC. HEAD courant observé : [`86959948`](https://github.com/AntheaLiles/k7pl/commit/86959948ff36deb6e8ee0985cf22740787696720). [Scorecard #38094666898](https://github.com/AntheaLiles/k7pl/actions/runs/38094666898) réussit. La première tentative du [run CI #38094667153](https://github.com/AntheaLiles/k7pl/actions/runs/38094667153) a rencontré une erreur TLS sur `Install elan`, mais sa tentative 2 s'est achevée en succès (`CI OK`) avec Lean, Verso, tests Python, PDF, contrôles de sécurité et OSV verts. Le workflow a également déployé GitHub Pages et rafraîchi la PR automatisée #148 ; ce sont des effets du workflow existant, pas une réponse BadgeApp, une release ou une publication Zenodo.
- [ ] **Exécuter le contrôle de dérive post-fusion** : le dernier run CI sur `main` est un événement `push` ; le job « Detect upstream BadgeApp criteria drift » y est `skipped` et aucun artefact `badge-criteria-drift-*` n'y a été produit. Une lecture read-only ponctuelle des deux fichiers amont retrouve les Blob SHA épinglés dans le registre, mais elle ne remplace pas la preuve du job. Déclencher `Security` avec `workflow_dispatch` depuis GitHub Actions, ou attendre un événement `schedule`, puis inspecter le job et l'artefact JSON.
  - `unchanged` : consigner la date et les Blob SHA amont observés.
  - `drift` : comparer les définitions officielles, examiner leurs effets, puis proposer une mise à jour du registre dans une PR ; ne jamais régénérer silencieusement le snapshot.
  - `unavailable` : résultat inconclusif, pas une preuve d'absence de dérive. L'exécution `workflow_dispatch` n'a pas pu être lancée avec les outils GitHub en lecture seule disponibles dans cette session.
- [ ] **OSV-Scanner** : le run [CI #38094667153](https://github.com/AntheaLiles/k7pl/actions/runs/38094667153) a terminé en succès à la tentative 2 ; le journal OSV annonce 14 paquets analysés dans le manifeste Lake converti et `No issues found`, avec un artefact SARIF de 589 octets. Examiner plusieurs exécutions planifiées, vérifier la couverture réelle et consigner le triage ; un scan de 14 paquets dans ce périmètre ne démontre pas une surveillance durable ni une couverture exhaustive.

## 1. Compléter la fiche Best Practices BadgeApp

1. [ ] Ratifier le **périmètre du logiciel produit par le projet** avant de choisir les champs ou déclarer un critère non applicable. Voir l'annexe D de [DECISIONS-REQUISES.md](DECISIONS-REQUISES.md).
2. [ ] Déterminer le nom public et la description à partir du projet réel ; vérifier la licence applicable aux artefacts ; mesurer les langages d'implémentation selon la définition BadgeApp plutôt que de les deviner.
3. [ ] Parcourir la [matrice critère par critère](BADGE-CONFORMANCE-MATRIX.md). Pour chaque critère, décider Met, Unmet ou N/A seulement sur la base de sa définition officielle et d'une preuve directe, datée et vérifiable. Un N/A doit être permis par la définition du critère et justifié par le périmètre ratifié.
4. [ ] Pour les réponses candidates, préparer une proposition selon le schéma de [BADGE-AUTOMATION.md](BADGE-AUTOMATION.md) et la valider avec le script scripts/ci/check_badge_proposals.py. Relire intégralement l'URL générée et chaque preuve avant de l'ouvrir.
5. [ ] Soumettre les choix **manuellement** dans [l'interface BadgeApp](https://www.bestpractices.dev/en/projects/15239/choose/edit). Ne pas utiliser les contrôles de forçage ni une écriture REST directe.
6. [ ] Après sauvegarde, relire la fiche et son export JSON depuis un accès réseau fonctionnel ; consigner la date, les réponses effectivement retenues et les éventuels écarts. Ne pas confondre proposition générée, réponse envoyée et réponse visible sur le site.

## 2. Vérifier le compte, les permissions et les paramètres GitHub

À réaliser avant tout essai de publication ou toute revendication fondée sur les réglages du dépôt.

- [ ] **Compte GitHub et Zenodo** : vérifier une 2FA résistante à l'hameçonnage, conserver des codes de récupération et documenter une procédure sûre de continuité/rotation d'accès.
- [ ] **Protection de main** : relire le ruleset actif. Décider explicitement D6 sur l'exigence de branche à jour (strict_required_status_checks_policy). Le réglage observé était false, avec zéro approbation requise ; ne pas présenter cette configuration comme une revue indépendante.
- [ ] **Règles de tags** : vérifier ou créer des règles couvrant spec-v* et v*, qui protègent création, mise à jour et suppression, interdisent les force-push et limitent le contournement. Aucun ruleset de tags n'a été confirmé par l'audit disponible.
- [ ] **Environnements** : configurer et protéger zenodo (tags de spécification uniquement) et bump-lean (branche main uniquement) ; vérifier la portée de github-pages.
- [ ] **Secrets et jetons** : déplacer les secrets de publication vers les environnements, puis supprimer les copies au niveau du dépôt ; remplacer/faire tourner BUMP_TOKEN vers un jeton limité au dépôt k7pl, avec uniquement Contents et Pull requests en lecture-écriture, sans permission Workflows et avec une expiration d'au plus 90 jours. Ne jamais afficher les valeurs de secrets dans les preuves.
- [ ] **Actions** : vérifier les permissions par défaut en lecture seule, l'approbation des workflows de forks externes et l'autorisation requise par le job status pour ouvrir sa PR générée. Ne pas désactiver l'autorisation de créer des PR sans adapter ce job.
- [ ] **Détection de menaces** : vérifier Secret scanning, Push protection et Dependabot alerts ; examiner les alertes et consigner le résultat sans publier de valeur sensible.
- [ ] **Capacités des agents (D3)** : décider les restrictions dans .claude/settings.json et les rôles des agents. Ne pas confondre instructions documentaires, configuration d'outils et garantie de sécurité ; vérifier le comportement obtenu.
- [ ] **Continuité d'accès** : vérifier les propriétaires et accès sensibles, l'accès Zenodo/ORCID et la récupération de compte. Le réglage « successor » de GitHub ne suffit pas à lui seul à assurer une continuité opérationnelle.

Les commandes de vérification API, les champs observés et les limites connues figurent dans [SECRETS-POLICY.md](SECRETS-POLICY.md) et [DECISIONS-REQUISES.md](DECISIONS-REQUISES.md).

## 3. Ratifier les choix de gouvernance et les affirmations publiques

- [ ] **D2 — Maintenir l'immuabilité et le modèle de publication en deux temps** : confirmer que le tag déclenche seulement la préparation d'un brouillon, que la mainteneuse contrôle les artefacts et vérifie l'attestation avant de publier, et que l'immuabilité des releases reste activée. Ne pas désactiver une protection pour contourner un échec ; une erreur déjà publiée impose une nouvelle version.
- [ ] **D9 — Gouvernance** : valider les rôles, les langues acceptées pour les signalements, le canal effectif du code de conduite et la décision DCO/CLA. Vérifier les liens et canaux réellement utilisables.
- [ ] **D5 — Métadonnées de publication** : corriger ou ratifier avant publication la formulation prétendant que la spécification a été vérifiée contre « l'implémentation de référence ». La preuve actuelle ne permet pas d'affirmer une correspondance spécification–implémentation qui n'a pas été observée.
- [ ] **D10 — Notes de version** : relire les notes de spec-v0.0.0-alpha.1 et décider la correction du changelog. La release existante est immuable ; ne pas tenter de la réparer en remplaçant tag ou assets.
- [ ] **D7 — Reproductibilité** : choisir l'ambition à poursuivre. Le PDF n'est pas démontré reproductible ; ne pas l'affirmer avant d'avoir épinglé et vérifié le bundle TeX, puis comparé des compilations indépendantes.
- [ ] **D8 — zizmor** : après examen des constats Code Scanning, décider séparément si le contrôle doit devenir bloquant. Ne pas le rendre bloquant uniquement pour augmenter un score.
- [ ] **D4 — Nom de fichier de la politique** : conserver l'explication de l'artefact de mesure, sauf décision explicite de renommage. Un changement destiné uniquement au score ne doit pas être présenté comme un gain de sécurité.
- [ ] **D11 — Job status** : relire ses permissions, son usage de credentials persistants et son mécanisme de poussée forcée ; décider si la conception doit évoluer, tout en conservant le fonctionnement utile de la PR de statut générée.

## 4. Éprouver release et Zenodo, sans publier prématurément

Ne pas démarrer cette phase avant les décisions D1/D5/D7/D10 et la configuration des environnements, secrets et règles de tags.

1. [ ] **D1 — DOI** : examiner l'enregistrement 10.5281/zenodo.23040451, établir son origine, déterminer s'il s'agit d'un DOI de concept ou de version et identifier son contenu. Choisir un seul canal de synchronisation (intégration native GitHub–Zenodo ou flux CI) et consigner le choix dans docs/tracking/DECISIONS.md.
2. [ ] Répéter sur le **sandbox Zenodo** le parcours contrôlé par un tag d'essai : contrôle du commit et de CI OK, build sans cache, brouillon contenant PDF, somme SHA-256 et bundle d'attestation, vérification locale puis nettoyage du brouillon et du tag d'essai avant toute publication.
3. [ ] Vérifier l'attestation depuis une machine avec accès réseau fonctionnel :
   ~~~sh
   gh attestation verify k7pl-spec.pdf --repo AntheaLiles/k7pl --bundle k7pl-spec.pdf.sigstore.json --signer-workflow AntheaLiles/k7pl/.github/workflows/release.yaml --source-ref refs/tags/spec-vX.Y.Z --source-digest "$(git rev-parse spec-vX.Y.Z^{commit})" --deny-self-hosted-runners
   ~~~
4. [ ] Relire les métadonnées et toutes les pièces du brouillon avant la publication ; vérifier le comportement d'archivage Zenodo et la provenance.
5. [ ] Seulement après résultat probant et décision explicite, effectuer la publication réelle. Le tag et les assets immuables ne sont pas réutilisables ; une erreur publiée requiert une nouvelle version.

La répétition workflow_dispatch précédente était un essai à blanc : elle n'a créé ni brouillon, ni asset, ni bundle d'attestation et n'a pas exercé le déclencheur réel par tag.

## 5. Fermer les critères qui exigent une preuve humaine ou une validation différée

- [ ] **Revue de sécurité humaine (Gold)** : conduire une revue personnelle, datée et signée couvrant exigences et frontières de sécurité. Les audits d'agents et le modèle de menace ne suffisent pas. Ne pas créer un fichier attestant cette revue avant de l'avoir réellement faite.
- [ ] **Preuves temporelles** : relever les délais de réponse aux rapports et vulnérabilités sur les fenêtres exigées ; une absence de données ou une seule exécution ne satisfait pas automatiquement ces critères.
Le suivi OSV-Scanner est maintenu à l'étape 0 pour conserver un ordre d'exécution unique ; ne le marquer clos qu'après plusieurs exécutions planifiées et consignation du triage.
- [ ] **PDF/TeX** : si l'ambition de reproductibilité est retenue, obtenir une provenance vérifiable du bundle, épingler son empreinte et exécuter les comparaisons indépendantes avant de fermer R11/R21.
- [ ] **SBOM/SPDX (R25)** : conserver le chantier technique distinct ([issue #122](https://github.com/AntheaLiles/k7pl/issues/122)). Le document SPDX généré a été accepté par le validateur indépendant hash-locké `spdx-tools 0.8.5` dans la CI #891 ; cette réussite porte sur le document exact, pas sur l'exhaustivité. Il reste à ratifier le périmètre des artefacts couverts et à terminer l'évaluation du corpus négatif et des runs indépendants.
- [ ] Après chaque série de décisions, mettre à jour la [matrice](BADGE-CONFORMANCE-MATRIX.md) en conservant séparées preuve du dépôt, preuve d'exploitation, réglage externe et jugement humain ; refaire une passe finale avant toute demande de niveau.

## Conditions de clôture

La campagne ne sera close qu'une fois les preuves humaines et externes enregistrées, les décisions ouvertes ratifiées, la fiche BadgeApp vérifiée après sauvegarde et les essais de publication documentés. La CI verte est nécessaire, mais elle ne remplace aucune de ces conditions.


## 6. Clôture humaine du premier chantier de navigation interactive

> **Périmètre distinct de l'OpenSSF.** Cette section rassemble les opérations qui ne peuvent pas être attestées par l'agent ou par la CI seule. Elle sert de checklist de recette du prototype de navigation documentaire. Ne cocher une case qu'après exécution réelle et inscrire la date, le SHA contrôlé et les observations dans [le dossier du prototype](../tracking/NAVIGATION-PROTOTYPE.md).

### 6.1. Préconditions de publication

- [ ] **NAV-H01 — Revoir et intégrer la PR de navigation.** Ouvrir la [PR #208](https://github.com/AntheaLiles/k7pl/pull/208), relire le déplacement sous `scripts/ci/navigation_graph/`, le `README.md`, le workflow et les tests. Vérifier que la dernière exécution CI sur la tête de PR est entièrement verte ; ne pas assimiler les jobs déjà réussis à la réussite du workflow agrégé. Fusionner seulement après cette vérification.
- [ ] **NAV-H02 — Vérifier le build et la publication du même SHA de `main`.** Après fusion, relever le SHA exact de `main`, puis ouvrir le run GitHub Actions correspondant. Contrôler au minimum « Spécification Verso », « Contrôles rapides », « Tests de l'outillage Python » et le job de publication GitHub Pages lorsqu'il est déclenché. Vérifier que le site publié correspond au SHA testé ; une PR verte ou un artefact chargé avant la publication ne suffit pas.

### 6.2. Recette manuelle du site publié

Utiliser le lien GitHub Pages affiché dans les paramètres/sections de déploiement du dépôt ou dans le run de publication qui vient de réussir. Ne pas supposer qu'un artefact Actions signifie que le domaine public a déjà été mis à jour.

- [ ] **NAV-H03 — Tester l'entrée contextuelle dans chaque chapitre.** Depuis la page d'accueil et la page d'entrée de chaque chapitre de spécification présent au build (C1 à C7), ouvrir « Explorer les relations explicites de K7PL ». Pour chaque chapitre, vérifier que le graphe s'ouvre, que le nœud initial correspond à la page de départ, puis qu'un lien « Ouvrir » ramène au bon chapitre/fragment. Tester aussi une page HTML imbriquée dans au moins deux chapitres. Noter les chemins testés et le SHA du site.
- [ ] **NAV-H04 — Tester les contrôles en JavaScript activé.** Utiliser la recherche sur un titre et sur un type d'objet ; sélectionner un résultat puis un nœud SVG ; parcourir les profondeurs 1, 2 et 3 ; activer/désactiver séparément `contains`, `references` et `cites` ; vérifier le lien vers l'objet sélectionné, les liens de provenance des relations et le retour au point de départ. Au niveau 3, confirmer qu'un troisième niveau visible est effectivement dessiné lorsque le voisinage contient une chaîne de longueur suffisante.
- [ ] **NAV-H05 — Vérifier le clavier.** Sans souris, utiliser Tab/Shift+Tab pour atteindre la recherche, les contrôles, les boutons de liste et les liens ; ouvrir les objets avec Entrée ; vérifier l'activation des nœuds SVG avec Entrée et Espace ; vérifier que le focus reste visible, qu'aucun contrôle ne piège le focus et que les listes textuelles permettent le même parcours utile que le dessin.
- [ ] **NAV-H06 — Vérifier les largeurs étroites et l'agrandissement.** Tester au minimum une largeur de 320–360 px et une largeur de 390–430 px, en portrait, puis avec zoom navigateur à 200 %. Contrôler que les contrôles se réorganisent, que la liste reste utilisable, que le SVG est défilable horizontalement dans sa propre région et que la page entière ne perd pas l'accès aux liens. Relever navigateur, appareil/émulateur, largeur et défauts.
- [ ] **NAV-H07 — Vérifier le mode JavaScript désactivé.** Désactiver JavaScript et recharger le navigateur de navigation. Confirmer que l'avertissement explique la limite et donne accès à la spécification, au catalogue de figures et aux vues statiques C6/C3. **Ne pas** noter le graphe complet comme fonctionnel sans JavaScript : ce n'est pas son contrat actuel. Réactiver JavaScript après l'essai.
- [ ] **NAV-H08 — Examiner les textes éditoriaux.** Lire les six niveaux de C1 et de C3 sur le site publié, suivre chaque lien de source canonique et vérifier que le texte reste non normatif. En C3, contrôler notamment que les intervalles d'usage ne sont pas confondus avec les modes structurels, que `M_Rel` reste hors du périmètre normatif courant et que la proposition sur les morphismes conserve son statut `under-review` et ses obligations ouvertes. Pour un autre objet, vérifier que l'interface signale honnêtement l'absence d'explication dédiée au lieu d'en inventer une.

Pour chaque point NAV-H03 à NAV-H08, consigner **Réussi / Échec / Non applicable**, la date, le SHA de `main`, le navigateur/version, les appareils ou largeurs testés, un lien/capture non sensible le cas échéant et les défauts observés. Une case en échec doit ouvrir une correction avant de déclarer la recette réussie.

### 6.3. Décider de la clôture technique et de la valeur d'usage

- [ ] **NAV-H09 — Consigner la recette technique.** Reporter les résultats de NAV-H01 à NAV-H08 dans le [dossier du prototype](../tracking/NAVIGATION-PROTOTYPE.md) et le [plan interactif](../tracking/INTERACTIVE-EXPLORATION-PLAN.md). Corriger les échecs avant de marquer la première tranche de navigation comme techniquement close. La réussite de cette tranche ne signifie pas que l'utilité pédagogique du graphe est démontrée.
- [ ] **NAV-H10 — Exécuter le protocole comparatif avant toute extension du graphe.** Recruter huit lecteurs qui n'ont pas construit le prototype et connaissent peu ce parcours ; affecter aléatoirement quatre personnes au parcours manuel et quatre au prototype. Leur demander, en partant de `fig:comp-process` dans la page C6, de retrouver six éléments : déclaration Verso avec ligne exacte, source TikZ, sorties SVG/PDF disponibles, renderer `SpecExt.Float`, workflow de validation, puis retour à la figure rendue. Appliquer le même délai maximal de cinq minutes et ne pas aider avant son terme.
- [ ] **NAV-H11 — Enregistrer les données et appliquer la règle préenregistrée.** Pour chaque participant anonymisé, noter temps, exactitude des six éléments, transitions, sources homonymes/erronées, demandes d'aide, échec du retour et tout écart au protocole. Publier les observations individuelles anonymisées et les échecs, pas uniquement une moyenne. Poursuivre l'extension seulement si l'exactitude n'est pas inférieure au parcours manuel et si la médiane du temps parmi les réussites baisse d'au moins 20 %, ou si l'achèvement exact augmente d'au moins 25 points sans hausse des erreurs de source. Ces seuils sont des critères locaux exploratoires, pas une preuve statistique généralisable.
- [ ] **NAV-H12 — Ratifier le résultat et la prochaine étape.** Inscrire le résultat dans `NAVIGATION-PROTOTYPE.md`, y compris les cas où le parcours manuel est plus rapide. Si la règle n'est pas satisfaite, conserver le prototype étroit et ne pas étendre les relations ou la couverture éditoriale sur la seule base de l'existence du graphe. Si la règle est satisfaite, soumettre une proposition de deuxième parcours avec chaque relation justifiée par une source explicite et un nouveau critère d'acceptation.

### 6.4. Fiche de résultats à remplir

Copier/compléter la ligne correspondante après chaque essai ; conserver l'URL exacte du run CI et l'URL de la page testée.

| Contrôle | Résultat (Réussi / Échec / N/A) | Date et SHA `main` | Navigateur, appareil ou largeur | Preuve, défaut ou issue |
|---|---|---|---|---|
| NAV-H01 — CI de PR et revue | À remplir | — | — | |
| NAV-H02 — CI de `main` et publication | À remplir | — | — | |
| NAV-H03 — accueil + chapitres C1–C7 | À remplir | — | — | |
| NAV-H04 — contrôles interactifs et profondeur 3 | À remplir | — | — | |
| NAV-H05 — clavier et focus | À remplir | — | — | |
| NAV-H06 — petit écran et zoom | À remplir | — | — | |
| NAV-H07 — JavaScript désactivé | À remplir | — | — | |
| NAV-H08 — exactitude éditoriale C1/C3 | À remplir | — | — | |
| NAV-H09 — compte rendu de recette | À remplir | — | — | |

Pour le protocole comparatif NAV-H10/NAV-H11, consigner une ligne par participant dans une copie de ce tableau, sans information permettant de l'identifier :

| Participant anonymisé | Condition (manuel / prototype) | Temps (s) ou échec à 300 s | Éléments exacts (0–6) | Transitions | Sources erronées / homonymes | Aide demandée ? | Retour correct ? | Écart au protocole |
|---|---|---|---:|---:|---:|---|---|---|
| P01 | À affecter aléatoirement | | | | | | | |
| P02 | À affecter aléatoirement | | | | | | | |
| P03 | À affecter aléatoirement | | | | | | | |
| P04 | À affecter aléatoirement | | | | | | | |
| P05 | À affecter aléatoirement | | | | | | | |
| P06 | À affecter aléatoirement | | | | | | | |
| P07 | À affecter aléatoirement | | | | | | | |
| P08 | À affecter aléatoirement | | | | | | | |

Ne pas remplir fictivement ces tableaux : ils constituent un support de consignation, pas une preuve déjà recueillie.

**Règle d'état :** NAV-H01 à NAV-H09 ferment la recette technique uniquement lorsque tous les points pertinents ont une preuve datée et qu'aucun échec n'est sans correction ou décision documentée. NAV-H10 à NAV-H12 restent une porte de preuve de valeur avant extension ; ne revendiquer ni bénéfice d'usage ni compréhension accrue avant leur exécution.
