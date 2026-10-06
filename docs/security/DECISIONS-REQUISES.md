<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Décisions qui reviennent à l'autrice

| | |
|---|---|
| Nature | Liste de décisions **non prises** par la session d'agents, avec une recommandation. Rien de ce qui est listé ici n'a été appliqué. |
| Pourquoi | Chacune touche à un objet qui relève de l'autrice : manuscrit et métadonnées de publication, permissions des agents, identifiants publics (DOI), engagements envers les utilisateurs, ou configuration GitHub. |
| Lecture | Pour chaque décision : contexte (fait), options, **recommandation** de la session, conséquence. |

Les extraits de texte proposés en annexe sont des **propositions de rédaction**, pas des affirmations validées.

## D1. Origine du DOI `10.5281/zenodo.23040451` : à établir avant toute publication par la CI

- **Contexte (fait).** Le DOI figure dans `CITATION.cff` et `README.md` depuis le commit `05aa321` (2026-10-01). Le seul run de
  release (2026-09-29) a échoué avant toute étape Zenodo, et la branche `zenodo-state` n'a jamais existé. L'origine du DOI (création
  manuelle ? intégration native GitHub-Zenodo ?) n'est établie nulle part dans le dépôt. Si l'intégration native est encore active,
  chaque release future créera **un second enregistrement** en plus de celui de la CI.
- **Options.** (a) Garder l'intégration native de Zenodo et supprimer la publication par la CI. (b) Garder la publication par la CI
  (`zenodo.yaml`) et désactiver l'intégration native. (c) Rester dans le flou : à écarter.
- **Recommandation.** Ouvrir l'enregistrement, noter s'il s'agit du DOI de concept ou de version et ce qu'il contient, regarder si
  l'intégration est active, puis choisir **un seul** canal et consigner la décision dans `docs/suivi/DECISIONS.md`. Répéter d'abord
  sur le sandbox Zenodo.
- **Conséquence.** `zenodo.yaml` refuse de publier tant que la variable `ZENODO_CONCEPT_RECID` n'est pas renseignée (entier, ou
  `NEW` pour créer explicitement un nouveau concept). Un DOI publié est irréversible.

## D2. Garder les releases immuables et adopter la nouvelle procédure de publication

- **Contexte (fait).** La release `spec-v0.0.0-alpha.1` est immuable. Le flux actuel (publier la release, puis y joindre le PDF) est
  incompatible avec l'immuabilité.
- **Options.** (a) Garder l'immuabilité et changer la procédure : pousser le tag, relire le brouillon produit par la CI, rejouer
  `gh attestation verify`, **publier**. (b) Désactiver l'immuabilité : à écarter, elle protège réellement le tag et les assets.
- **Recommandation.** (a). C'est le changement de pratique le plus visible de cette campagne : la publication devient un geste
  humain en deux temps (relire le brouillon, puis publier). Une erreur après publication ne se répare pas : il faut une nouvelle
  version, et le nom du tag n'est pas réutilisable.
- **Conséquence.** `CONTRIBUTING.md` décrit la nouvelle procédure. La release `spec-v0.0.0-alpha.1` reste sans artefact : elle ne se
  « répare » pas.

## D3. Restreindre ce que les agents peuvent faire dans le dépôt

- **Contexte (fait).** 49 des 69 commits de `main` portent l'auteur « Claude ». Les PR sont ouvertes sous l'identité de l'autrice et
  fusionnées sans revue enregistrée. Les sessions disposent d'outils de fusion de PR. Aucune configuration ne restreint un agent.
  L'audit d'assurance classe l'agent de code piégé (injection de prompt par une issue, une PR ou un fichier) comme le vecteur le
  plus vraisemblable aujourd'hui.
- **Options.** (a) Interdire la fusion et l'activation de la fusion automatique par les agents (extrait en annexe B). (b) Ne rien
  changer et le documenter comme risque accepté.
- **Recommandation.** (a), plus la restriction d'outils par rôle pour les agents d'audit et de revue (lecture seule). Ces fichiers
  relèvent de `.claude/` : la session ne les modifie pas de sa propre initiative.
- **À vérifier au passage.** Les définitions `.claude/agents/*.md` commencent par un commentaire SPDX avant le bloc de métadonnées
  `---`. Si l'interface ne lit les métadonnées qu'en tête de fichier, `model`, `effort` et `isolation` seraient ignorés. Dans la
  session qui a produit ces audits, aucun des six agents n'était résolu comme type de sous-agent : ils ont été lancés comme agents
  généraux qui lisent leur propre définition. **Hypothèse non testée** ; la vérification est la sortie de `/agents` (voir
  `ACTIONS-HUMAINES.md`).

## D4. Security-Policy 4/10 : artefact de nommage

- **Contexte (fait).** Scorecard apparie les fichiers par nom de base sans casse et s'arrête au premier lu : `.claude/rules/security.md`
  fait écran à `SECURITY.md`. Démontré par expérience : le même dépôt avec ce fichier renommé obtient 10. La politique réelle est
  complète et le signalement privé est activé.
- **Options.** (a) Renommer `.claude/rules/security.md` (par exemple en `assurance.md`) : +6 points sur ce contrôle, sans effet sur
  la sécurité. (b) Ne rien changer et documenter l'artefact.
- **Recommandation.** (b). Le fichier fait partie de l'infrastructure d'agents, et le seul bénéfice du renommage est le score. Si
  l'autrice préfère (a), c'est légitime à condition de le présenter comme la correction d'un artefact de mesure.
- **Conséquence.** Le score de ce contrôle reste à 4.

## D5. Affirmation « vérifiée contre l'implémentation de référence » dans les métadonnées de publication

- **Contexte (fait).** `CITATION.cff` (résumé), `zenodo.json` (description) et `zenodo.files.json` disent la spécification vérifiée
  par Lean 4 contre « l'implémentation de référence » (Mathlib, CSLib). `src/` ne contient que trois modules jouets, et `spec/` et
  `tools/` n'importent ni `K7pl`, ni Mathlib, ni CSLib. **Zenodo figera ces métadonnées de façon irréversible** à la première
  publication.
- **Options.** Reformuler avant la première publication (proposition en annexe A), ou conserver en connaissance de cause.
- **Recommandation.** Reformuler. La session ne touche pas à ces fichiers : ils décrivent le statut de formalisation du manuscrit.
- **Conséquence.** Sans reformulation, l'enregistrement permanent affirmera un lien spécification ↔ implémentation que l'audit n'a
  pas pu observer.

## D6. `strict_required_status_checks_policy: true` sur le ruleset de `main`

- **Contexte (fait).** Le seul check requis (`CI OK`) n'est pas strict : la combinaison PR + `main` courant n'est testée qu'après
  fusion.
- **Recommandation.** L'activer. Coût : chaque PR doit être à jour avant fusion, donc une relance de CI après chaque mise à jour du
  tronc (jusqu'à 45 minutes pour le job Lean). Effet sur Scorecard : Branch-Protection 3 → 4.

## D7. Ambition de reproductibilité

- **Contexte (fait).** Lean → HTML/TeX est identique sur deux builds propres d'une même machine. Le PDF n'est pas démontré
  reproductible et ne peut pas l'être tel que le job est écrit (bundle TeX non épinglé et téléchargé à l'exécution).
- **Options.** (a) Documenter la limite et s'arrêter là. (b) Niveau 1 : double build quotidien du HTML/TeX. (c) Niveaux 1 et 2 :
  double compilation du PDF, avec enregistrement de l'empreinte du bundle TeX.
- **Recommandation.** (a) ou (b) maintenant ; (c) seulement après avoir observé un build sain en CI. Dans tous les cas, ne jamais
  écrire « reproductible » avant la démonstration correspondante.

## D8. Essayer zizmor sur les workflows

- **Contexte (fait).** Les workflows sont la surface d'attaque réelle et sont rédigés en partie par des agents. zizmor hors ligne :
  8 constats de gravité faible ; les audits en ligne (commits imposteurs, actions vulnérables) n'ont pas pu tourner ici.
- **Recommandation.** L'essayer d'abord sur une branche, puis décider s'il devient un contrôle requis. **Pas de CodeQL** : il ne
  couvre pas Lean et n'apporterait qu'un faux signal sur Scorecard.

## D9. Gouvernance, langue des signalements, DCO, canal du code de conduite

- **Contexte (fait).** Aucun document ne décrit qui décide, qui fusionne, qui publie. Rien n'indique qu'un signalement en anglais est
  accepté. Le canal du code de conduite (« message privé via le profil GitHub ») n'existe pas sur GitHub (ESTIMÉ). Un seul commit
  porte un `Signed-off-by`.
- **Recommandation.** Valider ou corriger le brouillon de gouvernance (annexe C), choisir la langue des signalements, adopter le
  DCO ou justifier son absence, désigner un canal de signalement qui existe. Aucune de ces décisions ne peut être prise par un agent.

## D10. Notes de la release `spec-v0.0.0-alpha.1` et `spec/CHANGELOG.md`

- **Contexte (fait).** Les notes de la release sont une liste de titres de PR générée automatiquement ; `spec/CHANGELOG.md` n'a pas de
  section pour `0.0.0-alpha.1`. Le critère CII `release_notes` n'est pas satisfait.
- **Recommandation.** Éditer les notes de la release sur GitHub (seul le texte des notes est modifiable ; les assets et le tag
  restent verrouillés) et cocher « pre-release ». Ajouter une section à `spec/CHANGELOG.md` modifierait `spec/` : décision de
  l'autrice, avec modification minimale.

## D11. Job `status` de `ci.yaml` (écriture dans le dépôt, ajouté sur `main` après l'audit)

- **Contexte (fait).** Sur `main`, le commit `105e09f` (« ci: update generated project status ») est signé par `github-actions[bot]` : le job
  `status` a donc déjà produit au moins une PR. Le job a `contents: write`, `pull-requests: write`, `persist-credentials: true`, pousse
  `automation/generated-status` avec `--force` et ouvre une PR avec `GITHUB_TOKEN`. zizmor (profil auditeur) signale `artipacked`
  (identifiants persistés) et deux permissions non commentées ; le profil courant ne signale rien de plus. Scorecard local (clé de lecture
  des fichiers) donne toujours 10 à Token-Permissions sur l'arbre fusionné, sans que cela dise ce que donnera l'évaluation en ligne.
- **Conflit avec une recommandation de la campagne.** `docs/security/ACTIONS-HUMAINES.md` § 1.5 proposait de décocher « Allow GitHub Actions
  to create and approve pull requests ». C'était écrit avant ce job ; il en dépend désormais. Le texte de `ACTIONS-HUMAINES.md` est corrigé ;
  le réglage GitHub lui-même n'a été ni lu ni modifié.
- **Options.** (a) Garder tel quel, régler « Actions peut créer des PR », accepter une PR de bot dont `CI OK` n'est probablement pas rapporté
  (ESTIMÉ) et qu'il faut donc traiter à la main. (b) Ajouter des commentaires aux permissions et passer par un jeton à granularité fine
  limité à `automation/*`. (c) Ne plus committer `docs/STATUS.md` et le publier comme artefact ou sur Pages : cela réalise la préférence
  d'automatisation de `docs/METHOD.md` sans écriture dans le dépôt, mais change votre conception.
- **Constat du réaudit de la vague 2 bis (hors périmètre, non corrigé).** `K7PL_VERIFICATION: success` est codé en dur dans `ci.yaml` et
  `scripts/generate_status.py` écrit « Lean build, tests, lint, and axiom audit : SUCCESS » même quand l'analyse d'impact a sauté ces jobs.
  `docs/STATUS.md` affiche `Implementation version: unknown` : le marqueur `version := "` ne correspond pas à `version := v!"…"` du lakefile.
  Le fichier embarque le SHA de `HEAD` : chaque fusion de la PR de statut peut en déclencher une autre (ESTIMÉ, non observé). Impact de sécurité
  nul ; mais un fichier « généré par la CI » qui affirme plus que ce qui a tourné contredit `docs/METHOD.md` (« distinguer ce qui a été établi »).
  Correctif minimal proposé : reporter l'état réel par surface depuis les sorties du job `impact`, et corriger l'extraction de la version.
- **Recommandation.** (a) à court terme, avec la protection par ruleset de la branche `automation/generated-status` (force-push interdit) ;
  (c) à étudier. Aucune modification de `ci.yaml` n'a été faite pour ce job : la conception est la vôtre.

---

## Annexe A. Proposition de rédaction pour D5

Remplace « vérifiée par Lean 4 contre son implémentation de référence (Mathlib, CSLib) » par une formulation que les audits ont pu
observer. Proposition à reformuler par l'autrice :

> Spécification du langage de programmation K7PL, écrite en Verso et compilée avec Lean 4. L'implémentation de référence
> (Lean 4, Mathlib, CSLib) est en cours de développement et n'est pas encore liée à la spécification.

À reporter de manière cohérente dans `zenodo.json` (champ `description`) et `zenodo.files.json` (champ `description`). Pour ces deux
fichiers, remplacer aussi « exemples vérifiés par Lean 4 » par une formulation vraie : la session n'a pas établi ce que « vérifié »
recouvre pour les exemples de code du manuscrit.

## Annexe B. Extrait de permissions pour D3

À ajouter à `.claude/settings.json` si l'option (a) est retenue (noms d'outils tels qu'ils apparaissent dans les sessions de cette
campagne ; à ajuster à votre configuration) :

```json
{
  "permissions": {
    "deny": [
      "mcp__github__merge_pull_request",
      "mcp__github__enable_pr_auto_merge"
    ]
  }
}
```

Le fichier contient déjà le hook `SessionStart` ; l'extrait s'ajoute à côté, il ne le remplace pas.

## Annexe C. Brouillon de description de la gouvernance (pour D9), **non validé**

À valider, corriger ou rejeter par l'autrice. Il ne décrit que des pratiques observées dans le dépôt ; chaque phrase doit rester vraie
le jour où elle est publiée.

> **Gouvernance de k7pl.** k7pl est porté par une seule personne, Cyprien PIERRE (compte GitHub `AntheaLiles`), qui décide du
> contenu, fusionne les changements et publie les versions. Toute proposition non triviale (changement du langage, nouvelle
> dépendance) est discutée dans une issue avant d'être implémentée. Les décisions de fond sont consignées dans
> `docs/suivi/DECISIONS.md`. Le manuscrit de la spécification ne se modifie qu'avec l'accord de l'autrice.
>
> Des agents d'assistance (Claude Code) rédigent, proposent et vérifient des changements. **Ils ne constituent pas une revue
> indépendante.** [À conditionner : « Ils n'approuvent ni ne fusionnent rien », vrai seulement si la restriction de la décision D3
> est appliquée ; sinon c'est une convention, non une garantie technique.]
>
> Aucune revue par une seconde personne n'a lieu aujourd'hui. Les changements passent par une pull request et par le check `CI OK`.
> [Continuité d'accès : à compléter par l'autrice.]

## Annexe D. Ce qu'est « le logiciel produit par le projet » (préalable au formulaire CII)

De nombreux critères du badge ne s'appliquent qu'au « logiciel produit par le projet ». Faits observés : `src/` contient trois
modules jouets, le langage n'est pas implémenté, la seule release est un document (la spécification), et le logiciel réellement
exécuté est l'outillage (`tools/`, `scripts/`, workflows). Proposition à déclarer, ou à corriger, dans la description du projet sur
bestpractices.dev avant de choisir un seul « N/A » :

> Les résultats actuels du projet sont (1) une spécification publiée (document, CC-BY-4.0) et (2) une bibliothèque Lean embryonnaire
> sans logiciel destiné à des utilisateurs finaux. L'outillage (`tools/`, `scripts/`) est du logiciel de construction.
