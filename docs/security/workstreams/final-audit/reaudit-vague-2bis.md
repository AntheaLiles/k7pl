<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Réaudit indépendant de la vague 2 bis

| | |
|---|---|
| Nature | Rapport d'un agent d'audit en lecture seule, **non validé par la mainteneuse**. Archivé tel que rendu, avec une section « Suites données » ajoutée par la session principale. |
| Date | 2026-10-06 |
| Tête auditée | `27127f1` (`git diff c9372cb..HEAD -- scripts .github`, 15 fichiers) |
| Étiquettes | **[EXÉCUTÉ]** commande lancée par l'auditeur ; **[LU]** `fichier:ligne` ; **ESTIMÉ** non vérifié |
| Limite | l'auditeur partage le modèle des agents qui ont écrit le code : indépendance organisationnelle, pas épistémique |

## 0. Verdict de l'auditeur

- **0 CRITIQUE, 4 IMPORTANTS, 13 MINEURS.**
- Les gardes demandées tiennent sur les chemins nominaux : `NEW` refusé avant tout réseau si `GITHUB_RUN_ATTEMPT != "1"`, tag annoté ou léger
  revérifié avant `gh release create`, aucune interpolation `${{ }}` dans un `run:`, `git diff` en échec fatal, manifeste Lake fermé par défaut.
- Deux revendications documentaires étaient fausses telles qu'écrites : « toute erreur après l'envoi de la publication écrit le résumé et sort en
  code 3 » (IMP-1) ; « le manifeste est contrôlé » alors que rien ne contrôlait un `lake-manifest.json` modifié par une PR ordinaire (IMP-3).

## 1. Ce que l'auditeur a exécuté

- `python3 -m unittest discover -s scripts/ci -p 'test_*.py'` : 258 tests réussis.
- `actionlint` 1.7.12 avec ShellCheck 0.9.0 sur `.github/workflows/` : sortie 0, aucun constat.
- Analyse YAML de tous les workflows : aucun `${{` dans un `run:` ; aucun `uses:` non épinglé sur 40 hexadécimaux (hors `./`) ; `secrets.*`
  seulement dans les étapes attendues (`Require a token` et `Open the pull request` pour `bump-lean`, `Publish on Zenodo` pour `zenodo`).
- **126 mutants** écrits à la main, un à la fois sur une copie hors dépôt : **119 tués, 7 survivants**. Trois survivants sont redondants ou
  équivalents (M38 et M48 de `check_manifest`, E4 de `impact.py`). Quatre sont de vrais trous de test : `..` dans `inputRev` (M04), préfixe
  parasite dans `lean-toolchain` (M31, `fullmatch` remplacé par `search`), deux déclarations `package` dans le lakefile (M43), expurgation du
  jeton dans le message `Refused:` (Z26).
- Plus de 60 cas JSON adverses sur `check_manifest.py` (interface réelle), 39 projets Lean jetables sur `check_lean_modules.py`, 10 dépôts git
  jetables sur `impact.py`.
- `sync_zenodo.py` rejoué avec de **vraies classes `requests`** (`Response`, `HTTPError`, `ReadTimeout`, `ConnectionError`).
- `git ls-remote` réel sur dépôt local (tag léger, annoté, imbriqué, leurre `x/refs/tags/v1.0.0`) ; bloc shell du tag (`release.yaml:336-351`)
  rejoué avec un `gh` factice, 9 scénarios.
- Non rejoué en réseau (consigne) : `--check-tags` et `--check-upstream`.
- Transparence de l'auditeur : un essai avec un faux jeton a tenté trois connexions vers `sandbox.zenodo.org` ; le proxy les a refusées
  (403 CONNECT). Aucune donnée réelle n'a été envoyée.

## 2. Constats

### IMPORTANTS

**IMP-1. `sync_zenodo.py` : après la publication, toute erreur n'aboutit pas à « résumé + code 3 ».**
Si la relecture `GET /records/<id>` renvoie un JSON qui n'est pas un objet : `AttributeError` non attrapée, sortie 1, aucun résumé ni consigne
« ne pas rejouer » (`read_published_record` ne validait pas le type ; `write_report` appelle `record.get`, hors `try`). `KeyboardInterrupt` et
`SystemExit` n'étaient pas attrapés (`except Exception`) : une annulation du job pendant ou juste après la requête de publication perdait le DOI.
Une exception autre qu'`OSError` dans `write_report` s'échappait en trace. Impact réel faible, étape irréversible. Correctif minimal proposé :
valider le type dans `read_published_record` ; entourer `write_report` ; attraper `BaseException` après `outcome.publishing`, imprimer le DOI et
ré-élever ; trois tests.

**IMP-2. `NEW` ne protège que contre le rejeu du même run.**
`load_config` compare `GITHUB_RUN_ATTEMPT` à `"1"` (vérifié : 2, absent ou `01` donnent la sortie 2 sans appel réseau). Rien n'empêche une
**seconde release** `spec-vX+1` avec la variable encore à `NEW`, ce qui créerait un second concept DOI. `already_archived` ne lit que la dernière
version. Correctif minimal proposé : documenter le risque résiduel dans le modèle de menace et exiger l'approbation de l'environnement `zenodo`
pour toute exécution `NEW` ; option côté code : refuser `NEW` si `GET /api/deposit/depositions` contient déjà un identifiant lié au dépôt.

**IMP-3. Un `lake-manifest.json` modifié par une PR ordinaire n'est contrôlé par aucun script.**
`check_manifest.py` n'était appelé que par `bump-lean.yaml` (étape « advisory » du job `build`, puis `open-pr`). `impact.py` classe
`lake-manifest.json` en validation complète, mais `verify.yaml` n'exécutait pas le script. Correctif minimal proposé : exécuter le contrôle hors
ligne à chaque modification de `lake-manifest.json` ou `lakefile.lean`.

**IMP-4. `docs/STATUS.md` généré affirme plus que ce qui a tourné** (job `status` de `ci.yaml`, hors des cinq questions posées).
`K7PL_VERIFICATION: success` est codé en dur ; `scripts/generate_status.py` imprime « Lean build, tests, lint, and axiom audit : SUCCESS » même
quand `impact` a sauté ces jobs. `docs/STATUS.md` affiche `Implementation version: unknown` : le marqueur `version := "` ne correspond pas à
`version := v!"0.1.0"` du lakefile. Le fichier embarque le SHA de `HEAD` : chaque fusion de la PR de statut déclenche une nouvelle PR
(ESTIMÉ, non observé). Impact de sécurité nul ; rangé IMPORTANT parce qu'un fichier « généré par la CI » produit une affirmation fausse.

### MINEURS

`check_manifest.py`
- **MIN-1.** Plantage (`TypeError: unhashable type`) au lieu d'un rejet propre si le `name` d'un paquet est une liste ou un objet. Échec fermé, avec trace.
- **MIN-2.** Valeurs libres acceptées : `version` et `fixedToolchain` quelconques ; `configFile`, `manifestFile`, `scope` : tout chemin simple ;
  `inputRev` : `heads/main`, `tags/v1`, ou absent. La docstring (« exactly the keys ») devrait dire « au plus ».
- **MIN-3.** Trous de test confirmés par M04, M31 et M43.
- **MIN-4.** Pas de détection de clé JSON dupliquée (Python garde la dernière ; Lean aussi, lu dans `Lean/Data/Json/Parser.lean`) : aucune divergence exploitable.

`sync_zenodo.py`
- **MIN-5.** Un jeton avec saut de ligne final donne `InvalidHeader … 'Bearer S3CRET\n'` : le message contient la valeur, et passe par `raise` sans
  `redact`. `repr(Config)` contient le jeton. `check()` imprime `response.text` brut. Atténuation probable : le masquage des secrets par GitHub (ESTIMÉ).
- **MIN-6.** Toutes les réponses 4xx à la requête de publication étaient traitées comme « rien n'a été publié » ; 408, 409 et 429 ne le prouvent pas.
- **MIN-7.** Expurgation du jeton dans `Refused:` non testée (Z26).

Workflows
- **MIN-8.** Les notes « Avant publication » ne demandent pas de revérifier que le tag vise toujours `$GITHUB_SHA` (le tag est mobile jusqu'à la publication).
- **MIN-9.** `--signer-workflow` : sémantique de préfixe non ancré ESTIMÉE (constat M1 de l'audit final, non traité). Correctif proposé : `--cert-identity …/release.yaml@refs/tags/<TAG>`.
- **MIN-10.** `bump-lean.yaml` : l'étape « advisory » fait échouer le job ; ce n'est pas un avertissement (nommage).
- **MIN-11.** `ci.yaml` `status` : `git push --force` sur une branche non protégée avec `persist-credentials: true` pendant `generate_status.py`. Documenté (D11) ; aucune faille supplémentaire trouvée.

`impact.py` et `check_lean_modules.py`
- **MIN-12.** Chemins imprimés bruts : un fichier nommé `::warning::pwned` apparaît comme `  ::warning::pwned` ; hypothèse ESTIMÉE sur le runner (retrait des espaces de tête avant d'interpréter une commande). Aucun secret en jeu.
- **MIN-13.** `srcDir := "src" / "x"` ou `"src" ++ "x"` était lu comme `"src"` ; une `lean_lib` déclarée mais jamais construite par la CI compte comme racine (le nom de l'étape est plus large que sa portée) ; le scan par défaut ne couvre que `src` et `tests` (`--dirs src tests spec tools` : 83 fichiers, sortie 0) ; trois fichiers de `tooling/prototypes-bcd/` ne sont construits par aucune cible.

## 3. Réponses de l'auditeur aux cinq questions

1. **`check_manifest.py` est fail-closed** sur les pistes demandées (clé inconnue, URL à fragment ou requête, `rev` en majuscules ou de 39 caractères,
   `inputRev` en `refs/…`, chemins `..`, paquet inconnu ou non apparié, doublons, types JSON inattendus, JSON racine non objet, imbrication de 100 000
   niveaux). La vraie garde d'appariement est l'égalité exacte `url == https://github.com/<dépôt de ce nom>`. Lecture de tags essayée avec un vrai git : léger,
   annoté, imbriqué, absent, leurre. Oracle des tests indépendant pour l'essentiel (45 mutants sur 50 tués).
2. **`sync_zenodo.py`** : conforme sur les cas testés (timeout, 5xx, échec de relecture : sortie 3 et résumé) ; non conforme pour IMP-1 et MIN-6. `NEW`
   refusé avant tout réseau, mais seulement pour le même run (IMP-2). 26 mutants sur 27 tués ; la doublure de l'API Zenodo est écrite par le même auteur :
   cohérence interne, pas contrat réel (ESTIMÉ).
3. **Workflows** : aucune injection, permissions minimales (seul `ci.yaml` `status` écrit), secrets cantonnés aux étapes attendues, tag revérifié avant
   `gh release create` (léger, annoté, imbriqué OK ; déplacé, profondeur > 5, objet qui n'est pas un commit, absent : échec avant la création), séparation
   avant/après publication conforme ; les drapeaux existent dans `gh` 2.89.0.
4. **`impact.py`** : 20 mutants sur 20 tués, aucun contournement par renommage, suppression, mode seul, échec de diff ou chemin hors liste.
   **`check_lean_modules.py`** : 19 mutants sur 19 tués ; la grammaire d'en-tête correspond au parseur de Lean 4.34 ; limites en MIN-13.
5. **Documentation** : surclaims relevés dans le README des workflows, `zenodo.yaml`, `CONTRIBUTING.md`, la docstring de `sync_zenodo.py` (IMP-1, MIN-6),
   `ASSURANCE-CASE.md` C4 (IMP-3), la docstring de `check_manifest.py` (MIN-2), le nom de l'étape de `verify.yaml` (MIN-13), `docs/STATUS.md` (IMP-4),
   `bump-lean.yaml` (MIN-10). Affirmations vérifiées vraies : 258 tests, `actionlint` sans constat, 14 paquets du manifeste réel, `impact.py` seule source
   des chemins « complets », `NEW` refusé avant réseau, `IMPLEMENTATION-STATUS.md` § 3 et § 9 lucides, aucun surclaim dans `THREAT-MODEL.md` et `SECURITY.md`.

## 4. Ce que l'auditeur a essayé de casser sans y parvenir

Contournements de `check_url` (`#`, `?`, `\n`, tabulation, userinfo, port, casse, `.git`, `/` final) ; substitution d'un paquet par un autre dépôt
autorisé ; `rev` accepté par `match` au lieu de `fullmatch` ; injection d'annotation via un nom de paquet (`clean()`) ; tag leurre dans `ls-remote` ;
contournement de `impact.py` par renommage, suppression, mode seul, échec de diff ; `import all`, `public meta import`, commentaires imbriqués dans
`check_lean_modules.py` ; refus de `NEW` avec tentative 2, absente ou `01` ; repli sur la production de `ZENODO_ENV` ; liens `latest_draft` et `record` ;
interpolation directe dans les `run:` ; allowlist gitleaks limitée à la valeur exacte `^tok-secret-0123456789$`.

## 5. Non vérifié par l'auditeur

Comportement réel de Zenodo (redirection de `/api/records/<concept>`, forme des `links`, latence d'indexation, `newversion`, codes 408, 409, 429) ;
sémantique de `gh api …/git/ref/tags/…` pour un tag annoté et `GITHUB_SHA` d'un tag annoté ; sémantique de `--signer-workflow` ; traitement des `::`
indentés par le runner ; `--check-tags` et `--check-upstream` en réseau ; comportement de Lake avec un `configFile` altéré ; concurrence du groupe `zenodo` ;
environnements, règles de tags, immuabilité, 2FA ; aucun workflow n'a tourné sur GitHub ; Python 3.11 en local, 3.13 en CI.

## 6. Suites données par la session principale

Chaque ligne cite le commit ; la vérification est celle des tests (mutation ciblée, voir `quality-reproducibility/VALIDATION.md` et le commentaire de commit)
et du run de CI indiqué dans `IMPLEMENTATION-STATUS.md` § 12.

| Constat | Suite | Statut |
|---|---|---|
| IMP-1 | `read_published_record` valide le type ; `write_report` ne propage plus d'erreur ; interruption : DOI imprimé puis ré-élevée ; 5 tests, 11 mutants tués (`b8ee3b6`) | corrigé |
| IMP-2 | non corrigé dans le code : documenté dans `THREAT-MODEL.md` ; option côté code (refuser `NEW` si un dépôt lié existe) laissée à la mainteneuse | `HUMAN ACTION REQUIRED` |
| IMP-3 | `check_manifest.py` (hors ligne) lancé dans le job d'impact de `ci.yaml` à chaque exécution (`310954d`) ; observation en CI : voir `IMPLEMENTATION-STATUS.md` § 12 | corrigé, vérifié en CI (voir § 12) |
| IMP-4 | fichier et job de `main`, hors du périmètre de la campagne : consigné dans `DECISIONS-REQUISES.md` D11 | `HUMAN ACTION REQUIRED` |
| MIN-1, MIN-2, MIN-3 | noms non textuels rejetés, `configFile`, `manifestFile`, `version`, `fixedToolchain` contrôlés, tests des trois trous (`310954d`) | corrigé |
| MIN-4 | aucune divergence exploitable | sans suite |
| MIN-5 | jeton refusé s'il n'est pas ASCII imprimable sans espace, `repr=False`, corps de réponse cités (`b8ee3b6`) | corrigé |
| MIN-6, MIN-7 | seuls 400, 401, 403, 404 et 422 prouvent l'absence de publication ; test de l'expurgation du jeton (`b8ee3b6`) | corrigé |
| MIN-8 | notes de brouillon : deux commandes pour revérifier le tag (`5e4edcf`) | corrigé |
| MIN-9 | sémantique non vérifiée ; non modifié | ESTIMÉ, à vérifier par la mainteneuse |
| MIN-10 | étape renommée, commentaire corrigé (`310954d`) | corrigé |
| MIN-11 | documenté (D11) | sans suite |
| MIN-12 | chemins cités par `repr` ; test (`e0f9999`) | corrigé |
| MIN-13 | `srcDir`, `roots`, `root` doivent être le littéral entier de leur ligne ; portée écrite dans `verify.yaml` (`e0f9999`) ; extension à `spec` et `tools` non faite (décision de la mainteneuse) | corrigé en partie |
