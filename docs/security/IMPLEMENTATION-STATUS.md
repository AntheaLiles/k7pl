<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# État de la mise en œuvre de la campagne OpenSSF

| | |
|---|---|
| Nature | Enregistrement **daté** de ce qui a été fait, de ce qui ne l'a pas été et de ce qui a réellement été exécuté. Produit par la session principale ; **non validé par la mainteneuse**. |
| Date | 2026-10-06 |
| Branche | PR #28, **fusionnée dans `main` par rebase** le 2026-10-06 (commits `b94a4e3`, `ab070c6`, `da1abb1`, copies réécrites par le rebase) ; ce document est mis à jour par une PR de suite |
| Point d'entrée | [`README.md`](README.md) ; l'état factuel courant du dépôt est dans [`../STATUS.md`](../STATUS.md) (généré par la CI) |
| Statuts | `VERIFIED` · `PARTIAL` · `PREPARED` · `HUMAN ACTION REQUIRED` · `BLOCKED` · `FUTURE` |

Les chiffres de ce document sont des **observations à une date**, pas des valeurs maintenues : au sens de [`../METHOD.md`](../METHOD.md),
ce qui se dérive d'une source automatique (comptes, scores, états de CI) doit être relu à la source, pas ici.

## 1. Résumé

- Le score Scorecard passe de **6,0** (`b5f6146`, run 37385570410, 2026-10-05) à **6,1** (`da1abb1`, run 37524313277, 2026-10-06), lus dans les
  journaux du job `Scorecard`. La seule différence de contrôle est **Pinned-Dependencies 9 → 10**, comme le prévoyait la mesure locale. Les
  autres écarts de score dépendent de réglages GitHub et de pratiques humaines que le dépôt ne peut pas modifier seul.
- Les contrôles de CI ont été renforcés (modules Lean jamais compilés, audits d'axiomes étendus, analyse d'impact testée). Une
  **chaîne de publication attestée** (brouillon de release, attestation, archivage Zenodo vérifié) est écrite mais **n'a jamais été
  exécutée de bout en bout** : `PREPARED`, pas `VERIFIED`.
- Aucun artefact signé, aucune provenance, aucun SBOM, aucune preuve de reproductibilité du PDF n'a été produit ni revendiqué.
- Le niveau « Gold » des bonnes pratiques est structurellement hors d'atteinte pour une seule mainteneuse ; « Silver » ne l'est pas en
  l'état ; « Passing » est atteignable par des actions humaines.
- **La campagne est fusionnée ; il reste des réglages à faire et des décisions à prendre** : voir `ACTIONS-HUMAINES.md` § 0 et les décisions D1 à D11.

## 2. Réalisé (`VERIFIED`)

| Élément | Preuve |
|---|---|
| Six audits indépendants, matrice des écarts, plan, décisions, actions humaines, modèle de menace, registre des revendications | fichiers de ce dossier ; relus par deux audits finaux (`workstreams/final-audit/`) |
| `check_lean_modules.py` : un module Lean que `lake build` ne compile jamais fait échouer la CI | code de sortie 0 sur le dépôt réel, 1 sur un mini-projet avec orphelin ; étape exécutée en CI (run 37424012908) |
| Audits d'axiomes de `K7pl`, des modules de test, de `Spec`, `SpecExt`, `SpecBib` | exécutés en CI, run 37424012908, sortie lue |
| `scripts/ci/impact.py` seule source des chemins qui forcent la validation complète ; un `git diff` en échec ne valide plus « rien » | 276 tests, mutants ciblés tués (`workstreams/quality-reproducibility/VALIDATION.md`, `workstreams/final-audit/reaudit-vague-2bis.md`) |
| Faux positif gitleaks sur la valeur de test de `test_sync_zenodo.py` | exécution avant/après et contrôle négatif avec gitleaks 8.24.3 (la version de la CI) |
| Pinned-Dependencies 9 → 10 (hook de session sans `curl … \| sh`) | mesure locale sur un export propre, puis journaux du job `Scorecard` de `main` avant et après (voir § 4) |

## 3. Partiellement réalisé (`PARTIAL`) et préparé (`PREPARED`)

| Élément | État | Ce qui manque |
|---|---|---|
| `release.yaml` : tag → contrôles → reconstruction sans cache → **brouillon** de release (PDF, somme, attestation Sigstore) ; publication humaine | `PREPARED` | exécution réelle (répétition sur un tag d'essai) ; la résolution du tag par l'API n'a été testée qu'avec un `gh` factice |
| `zenodo.yaml` + `sync_zenodo.py` : vérifie la release publiée, l'attestation, puis dépose ces octets ; échec par défaut si le concept n'est pas déclaré ; code de sortie 3 après l'envoi de la publication | `PREPARED` | exécution réelle sur le sandbox Zenodo ; la doublure de l'API Zenodo est écrite par les agents ; l'hôte est refusé depuis la session |
| `bump-lean.yaml` en deux jobs ; `check_manifest.py --check-tags --check-upstream` | `PREPARED` | jamais exécuté dans GitHub ; ne détecte ni un paquet omis ni un commit malveillant épinglé par un manifeste amont |
| PDF : `SOURCE_DATE_EPOCH`, `-Z deterministic-mode`, journal conservé | `PARTIAL` | **le PDF n'est pas démontré reproductible** (bundle TeX non épinglé, aucune double compilation comparée) ; seule la génération HTML/TeX a été observée identique sur deux builds **d'une même machine** |
| Documentation alignée (README des workflows, CONTRIBUTING, SECURITY, CHANGELOG) | `PARTIAL` | la procédure de vérification d'une release est une cible, non éprouvée |
| Hook de session : elan par version et somme SHA-256 | `PREPARED` | la somme est celle de la première observation, pas publiée par l'amont ; non exécuté dans une session neuve |

## 4. Scorecard avant et après

Les deux évaluations sont celles du job `Scorecard` de `main` (Scorecard v5.5.0, évaluation **en ligne**, avec l'API de GitHub), lues dans les journaux :
avant la campagne sur `b5f6146` (run 37385570410, 2026-10-05) ; après la fusion sur `da1abb1` (run 37524313277, 2026-10-06). **Score global : 6,0 → 6,1.**

| Contrôle | Avant | Après | Observé |
|---|---:|---:|---|
| Binary-Artifacts | 10 | 10 | |
| CI-Tests | 10 | 10 | 5 sur 5 PR fusionnées, puis 14 sur 14 |
| CII-Best-Practices | 2 | 2 | badge « InProgress » ; action humaine |
| Code-Review | 0 | 0 | 0 sur 4 changesets approuvés, puis 0 sur 13 ; une seule personne (structurel) |
| Contributors | 6 | 6 | « anthropics, freeengineering » d'après les métadonnées des commits ; ne représente pas des contributeurs indépendants |
| Dangerous-Workflow | 10 | 10 | |
| Dependency-Update-Tool | 10 | 10 | |
| Fuzzing | 0 | 0 | délibéré |
| License | 9 | 9 | `LICENSE.md` n'est pas reconnu comme licence FSF ou OSI |
| Maintained | 0 | 0 | dépôt créé il y a moins de 90 jours |
| Packaging | −1 | −1 | sans objet |
| **Pinned-Dependencies** | **9** | **10** | 29 sur 29 puis 34 sur 34 actions GitHub épinglées ; le téléchargement suivi d'une exécution du hook de session (0 sur 1) a disparu |
| SAST | 0 | 0 | délibéré |
| Security-Policy | 4 | 4 | « no linked content found » ; voir D4 |
| Signed-Releases | −1 | −1 | aucune release avec artefact |
| Token-Permissions | 10 | 10 | écritures au niveau d'un job : avant `bump-lean.yaml:23`, `release.yaml:92` et `:125` ; après `ci.yaml:125` (job `status`, venu de `main`) et `release.yaml:233` (job `draft`) |
| Vulnerabilities | 10 | 10 | |
| Branch-Protection | 3 | 3 | mêmes avertissements : pas d'approbation requise, pas de revue par les propriétaires de code, branches à jour non exigées (D6) |

La mesure locale en mode fichier avait prévu cette différence et elle seule (Pinned-Dependencies 9 → 10) : sur les neuf contrôles qu'elle couvre, elle
concordait avec les journaux de CI avant comme après.

Les 0 de Fuzzing et SAST sont délibérés : aucun outil de SAST ne couvre Lean (le SARIF de Scorecard n'est pas un SAST) et `src/` n'a presque aucune
surface d'entrée. Aucun outil n'a été ajouté pour remonter ces scores. Les écarts restants (Code-Review, Branch-Protection, Maintained, CII,
Signed-Releases) relèvent de pratiques ou de réglages humains, ou du temps.

## 5. Bonnes pratiques (CII)

Aucune lecture ni écriture sur `bestpractices.dev` n'était possible (hôte refusé). Évaluation sur les fichiers, d'après le référentiel :

| Niveau | Critères | Lecture |
|---|---:|---|
| Passing | 67 | atteignable ; nécessite de renseigner le formulaire critère par critère (`ACTIONS-HUMAINES.md` § 4) et des décisions de contenu (D9) |
| Silver | 55 | pas en l'état : exige notamment des revues, une gouvernance documentée et une continuité d'accès à plusieurs personnes |
| Gold | 23 | **structurellement impossible** à une seule mainteneuse (deux contributeurs distincts, revue indépendante) ; aucune pratique n'a été simulée pour y prétendre |

## 6. Action humaine requise (`HUMAN ACTION REQUIRED`)

Aucune n'a été faite ni vérifiée. Liste complète et ordonnée : [`ACTIONS-HUMAINES.md`](ACTIONS-HUMAINES.md). Les plus lourdes de conséquences :

1. **D1** : établir l'origine du DOI `10.5281/zenodo.23040451` **avant toute publication** (un enregistrement Zenodo ne se retire pas).
2. **D2** : adopter la nouvelle procédure de publication, qui garde les releases immuables ; ne pas désactiver l'immuabilité pour contourner la CI.
3. Créer les environnements `zenodo` et `bump-lean` avec leurs protections **avant** de fusionner la branche.
4. Règle de tags `spec-v*`/`v*` qui restreint aussi la **création** ; 2FA par clé d'accès ; continuité d'accès.
5. **D3** : restreindre les outils de fusion des agents (`.claude/settings.json`), décision non appliquée.
6. **D11** : le job `status` de `main` dépend du réglage « Actions peut créer des PR », que la campagne avait recommandé de décocher.

## 7. Bloqué (`BLOCKED`)

| Élément | Cause |
|---|---|
| Lecture des réglages GitHub (ruleset, environnements, immuabilité, secret scanning) avec droits d'administration | jeton de session sans ces droits ; plusieurs lectures faites avec un jeton d'intégration à portée limitée (ESTIMÉ pour la plupart) |
| Lecture de `bestpractices.dev`, Zenodo, doi.org, Software Heritage, `api.securityscorecards.dev` | hôtes refusés par le proxy de la session |
| Exécution locale de `lake build K7pl`, `lake test`, `lake lint` | Mathlib absent de la session ; ces commandes n'ont tourné **qu'en CI GitHub** |
| Exécution de `release.yaml`, `zenodo.yaml`, `bump-lean.yaml` | aucune écriture GitHub n'était autorisée (ni tag, ni release, ni dispatch) |

## 8. Futur (`FUTURE`)

Signature et provenance des releases au-delà du PDF, SBOM, SLSA (aucun niveau revendiqué), `lean4checker` sur les oléans de Mathlib, extension de
`check_lean_modules.py` à `tools/` et `spec/`, reproductibilité du PDF (D7), zizmor comme contrôle requis (D8), revue de sécurité humaine datée et signée.

## 9. Risques résiduels

- **Mono-mainteneuse** : zéro revue indépendante, zéro approbation requise ; un compte compromis compromet le projet. Les mitigations (2FA,
  règle de tags, environnements) sont des actions humaines non vérifiées.
- **Agents** : des sessions d'agents agissent sous l'identité de la mainteneuse avec des outils de fusion (D3).
- **Amont** : elan, Lean, Mathlib, Tectonic et son bundle TeX sont exécutés sans vérification de leur provenance au-delà des sommes enregistrées dans le dépôt.
- **Publication irréversible** : DOI et release immuable ; la chaîne n'a pas été répétée.
- **Job `status`** : écriture dans le dépôt depuis `main`, ajouté après l'audit, non audité en profondeur (D11).
- Les agents d'audit final partagent le modèle et le dépôt des agents d'implémentation : leur indépendance est organisationnelle, pas épistémique.
- Les corrections de la vague 2 bis ont été réauditées par un agent indépendant (`workstreams/final-audit/reaudit-vague-2bis.md` : 0 critique, 4 importants, 13 mineurs). Les corrections qui répondent à ce réaudit n'ont **pas** fait l'objet d'un nouvel audit : relues et vérifiées par la session principale (tests, mutation ciblée), exécutées en CI sur `5e4edcf`.
- **Coût de maintenance du contrôle de manifeste** : `check_manifest.py` est lancé à chaque exécution de CI et ne connaît que 14 paquets. Une nouvelle dépendance
  transitive, ou un changement de forme du manifeste de Lake (`version`, `configFile`, nouvelle clé), fait échouer la CI jusqu'à ce qu'une personne mette à jour
  la liste : c'est voulu (échec fermé), mais c'est une charge pour une seule mainteneuse et la PR de `bump-lean` ne s'ouvrira pas seule dans ce cas.
- **Taille de la PR** : un seul commit et plus de 10 000 lignes ajoutées, dont plus de la moitié de documentation d'agents non validée. Une revue réelle suppose de
  lire d'abord les fichiers sensibles listés dans la PR ; découper la campagne en PR séparées (audit, contrôles de CI, chaîne de publication) aurait réduit le risque de régression.
- **Second concept DOI** : `NEW` ne protège que du rejeu du même run ; une seconde release avec la variable encore à `NEW` créerait un second concept (`THREAT-MODEL.md`).

## 10. Intégration de `main` et conventions de commit

Constat : `main` a avancé pendant la campagne (architecture documentaire courante, `docs/STATUS.md` généré, `CODE_OF_CONDUCT/`, `DEI.md`,
annexes B à D extraites de `spec/`, job `status` de `ci.yaml`). La branche a été fusionnée avec `main` (`4a8c34f`) ; le seul conflit était `README.md`
(badges redistribués par `main`), résolu en gardant la structure de `main` et les formulations vérifiables de la branche. `docs/STATUS.md`
n'est pas touché.

Contrôle de **Conventional Commits** : `@commitlint/cli` 19 avec `.commitlintrc.yaml` (la configuration de la CI), exécuté sur les 43 commits de la branche
avant l'aplatissement. **Un seul échec** : `ci(release): revérifier le tag avant la création du brouillon et séparer les commandes de vérification`
(en-tête de 102 caractères, limite 100), qui faisait échouer `Conventional Commits / commitlint` puis `CI OK` sur la PR (run 37521070000). La réécriture ciblée
(rebase) a été refusée par le système de permissions de la session, puis la mainteneuse a décidé d'**aplatir la branche en un seul commit**. Le commit unique
(en-tête de 93 caractères) passe `commitlint` en local ; le contrôle de la PR sur ce commit est consigné au § 12.

Écart observé à signaler, sans l'avoir tranché : `CONTRIBUTING.md` et `.claude/skills/writing-rules.md` prescrivent des messages de commit et une
documentation en français ; les commits récents de `main` et les nouveaux documents de `docs/` sont en anglais.

## 11. Validation exécutée

Commandes **réellement lancées**, avec le résultat observé. Ce qui n'est pas listé n'a pas été exécuté.

| Contrôle | Où | Résultat |
|---|---|---|
| `python3 -m unittest discover -s scripts/ci -p 'test_*.py'` | local, sur la tête `5e4edcf` (avant aplatissement) | 276 tests réussis, puis 278 après les ajouts de l'autocritique (§ 13) |
| `actionlint` avec ShellCheck 0.9.0 (la version de la CI) sur `.github/workflows/*.yaml` | local, sur la tête fusionnée | 0 constat |
| `zizmor --offline` (profil courant) | local, sur la tête fusionnée | 7 constats de gravité faible, tous `self-repository` (appels `./.github/workflows/…`) ; le profil auditeur ajoute `artipacked` et deux permissions non commentées sur le job `status` |
| `gitleaks detect` 8.24.3 (historique complet) | local | aucune fuite |
| `python3 -m reuse lint` | local | conforme |
| `python3 scripts/controle.py` | local | tous les contrôles passent |
| `commitlint` 19 sur les 43 commits de la branche | local | 1 échec (voir § 10) |
| Liens Markdown relatifs (équivalent hors ligne du contrôle `lychee`) | local, sur tous les `.md` | 0 lien cassé |
| Scorecard v5.5.0 `--local` sur export propre | local | voir § 4 ; le contrôle `Vulnerabilities` échoue (API `osv.dev` refusée) |
| `lake build`, `lake test`, `lake lint`, audits d'axiomes, `lake build Spec`, rendu et PDF | **CI GitHub**, run 37424012908 sur `3fd82f1` (avant aplatissement) | réussis (journaux lus) |
| Même CI | run 37457714953 sur `ce606a9` (avant aplatissement) | **échec** : gitleaks (corrigé) et actionlint SC2015 (corrigé ensuite) |
| Même CI sur la tête `25eb642` | run 37505816526 | **réussi**, 13 jobs |
| Même CI sur la tête `5e4edcf` (après le réaudit et ses corrections) | run 37520170453 | **réussi** (voir § 12) |

Non exécuté : `lake build`, `lake test`, `lake lint` en local ; `python3 scripts/suivi.py all` (aucun fichier de suivi touché) ; tout workflow de
publication ; toute lecture des réglages GitHub avec droits d'administration. (L'évaluation Scorecard en ligne n'a pas été lancée à la main : elle est lue dans les journaux du job `Scorecard` de `main`, § 4.)

## 12. CI de la tête testée

Run 37520170453 (`ci.yaml`, déclenché à la main sur la branche, le 2026-10-06), commit **`5e4edcf`**, fusion de `main` à `4a8c34f` incluse, après le réaudit
indépendant et les corrections qui en découlent. Résultat : **succès**. Le run précédent (37505816526, commit `25eb642`) avait réussi lui aussi, avant ces corrections.

Journaux **lus** (run 37520170453) :

| Job | Observé |
|---|---|
| `Analyse d'impact` | `Check the Lake manifest` : `lake-manifest.json: all checks passed` (**première exécution en CI du contrôle de manifeste**) ; tests de `scripts/ci/` réussis ; classification `full=true` (déclenchement manuel) |
| `Vérification / Implémentation Lean` | `Check that every Lean file is built` réussi ; build de `K7pl` et `K7plTests` réussi ; `5/5 tests passed` ; `Linting passed for K7pl` ; audits d'axiomes dans la liste autorisée : `K7pl` 82 déclarations, `ArithTest` 2, `MainTest` 4, `SemanticsTest` 1 |

Statuts **lus** dans la liste des étapes de l'API, journal non relu pour ce run : `actionlint`, `gitleaks`, REUSE, `commitlint` (déclenchement manuel : dernier commit seulement), contrôle des liens locaux,
`Check the specification`, build de la spécification, audits d'axiomes de `Spec`, `SpecExt` et `SpecBib`, rendu HTML et TeX, compilation du PDF : tous réussis. Les journaux d'`actionlint`
(`Found 0 errors in 10 files`) et de `gitleaks` (`no leaks found`) ont été lus sur le run 37505816526.

Limites de cette exécution :

- **Le contrôle `commitlint` d'un déclenchement manuel ne regarde que le dernier commit.** Son succès ne contredit pas le constat du § 10 : sur une PR, il examinera chaque commit de la branche et le commit `4c6792b` (102 caractères) échouera.
- Les workflows `release.yaml`, `zenodo.yaml` et `bump-lean.yaml` sont analysés statiquement (actionlint, zizmor) mais **non exécutés** par ce run.
- Un run déclenché à la main n'exerce ni la publication Pages ni le job `status` : leur comportement sur `main` n'est pas observé ici.
- Le PDF compile : cela ne dit rien de sa reproductibilité (voir § 3).

Les commits `25eb642` et `5e4edcf` n'existent plus sur la branche (aplatissement, voir § 10) : les deux runs ci-dessus décrivent l'état exécutable de la campagne avant
l'aplatissement. Le commit unique a le même arbre que le dernier de ces deux commits à ses fichiers de documentation près ; le résultat de la CI **de la PR** sur le
commit courant n'est pas figé dans ce document (un document qui citerait le résultat de la CI de son propre commit obligerait à un commit de plus, donc à un nouveau
run) : il se lit dans les contrôles de la PR #28.

## 13. Autocritique et suites données

Autocritique de la session principale sur le travail poussé, et ce qui en a été fait. Rien ici n'est validé par la mainteneuse.

| Constat | Suite | Statut |
|---|---|---|
| Un commit à l'en-tête de 102 caractères avait été intégré sans `commitlint` ; la règle « vérifier avant de pousser » n'était écrite nulle part | `CONTRIBUTING.md` : critères exacts de la CI, chaque commit est lu, procédure de contrôle local (la commande documentée a été exécutée : code de sortie 0 sur la plage, 1 sur un en-tête trop long) | corrigé |
| Contrôle de manifeste trop coûteux à maintenir : message d'échec muet sur la marche à suivre ; `version` exigée à trois composantes sans preuve que Lake la garde | le message dit où ajouter une dépendance relue ; `CONTRIBUTING.md` décrit l'opération ; `version` accepte tout motif de nombres séparés par des points ; tests ajoutés | corrigé |
| Hypothèse non vérifiée sur le format des jetons Zenodo | écrite dans la docstring de `sync_zenodo.py` : l'hypothèse porte sur le format (ASCII imprimable sans espace), pas sur Zenodo | documenté |
| Deux décomptes incompatibles de `src/` (9 déclarations dans le registre, 82 constantes dans l'audit d'axiomes) | le chiffre à la main est retiré du registre et de la matrice : le décompte courant est celui de `docs/STATUS.md` | corrigé |
| Taille de la PR (un commit, plus de 10 000 lignes) | non corrigé : découper en trois PR (audit, contrôles de CI, chaîne de publication) demande des branches empilées, car `release.yaml` appelle des entrées de `verify.yaml` et les tests de `scripts/ci/` couvrent les trois ; plus de documents qui dépassent le code fusionné tant que l'ordre n'est pas respecté | `HUMAN ACTION REQUIRED` (choix de la mainteneuse) |
| Second concept DOI avec `NEW`, `--signer-workflow` non ancré, D3 (agents qui peuvent fusionner) | non corrigés : chacun demande soit une exécution contre Zenodo ou GitHub, soit une décision de la mainteneuse | `HUMAN ACTION REQUIRED` |
| Langue (français contre anglais récent de `main`), job `status` | non tranchés ; le job est consigné en D11 | `HUMAN ACTION REQUIRED` |

## 14. Observations après la fusion (2026-10-06)

Faits lus ou mesurés après la fusion de la PR #28 ; rien n'est déduit.

| Observation | Source |
|---|---|
| Fusion **par rebase** : les trois commits ont de nouveaux identifiants sur `main` ; la branche de la PR a disparu du dépôt distant (suppression automatique des branches fusionnées, ou geste de la mainteneuse) | historique de `main`, `git fetch` |
| Score Scorecard 6,1 (§ 4) | journal du run 37524313277 |
| Sur `main`, le job d'impact exécute `Check the Lake manifest` : `lake-manifest.json: all checks passed` | liste des étapes du run 37524313864 |
| **La PR #27** (« ci: add Python tooling validation and coverage controls », ouverte avant cette fusion) **est maintenant en conflit** avec `main` sur `ci.yaml`, `verify.yaml` et `scripts/ci/impact.py` : elle modifie des fichiers que la PR #28 a réécrits | `git merge-tree` local sur sa tête et sur `main` |

