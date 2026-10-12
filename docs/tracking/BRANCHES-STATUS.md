# Statut des branches de travail

**Rapprochement : 2026-10-12, sur `main` = `200b6935f5622e93d9add104e1f0e46dae6f6e6b`.**  
**État observé avant ce rapprochement :** 44 références de branche distantes (dont `main` et la branche de session `ccr-c4afa630-5uz1ic`) et trois PR ouvertes (#170, #182, #183).  
**Mises à jour du même jour :** #183 a été fusionnée (`ee0d05a`, arbre identique à sa tête), puis #184 (`main` = `e7c69aa`). Les branches `research/c-kernel-effective-rules-2026-10-12` et `rebase/feat/navigation-graph-mvp` ont été supprimées à la fusion.

Ce registre remplace l'inventaire du 11 octobre. Il réalise le passage d'hygiène annoncé par [l'instantané de reprise](RECOVERY-STATUS-2026-10-11.md), § 5 : pour chaque tête sans PR ouverte, il consigne s'il reste du contenu unique. Il recommande ; il **n'autorise ni fusion ni suppression**. Aucune branche n'a été supprimée ni réécrite pendant ce rapprochement. Les reprises sont portées par de nouvelles branches `rebase/…`, et les branches d'origine restent intactes.

## Méthode et limites

Faits observés, dans l'ordre :

1. Le clone de session était superficiel (50 commits). L'historique complet a été récupéré avant toute comparaison, car un clone superficiel fausse les comptes d'avance et de retard.
2. Pour chaque branche : `git cherry origin/main <branche>` (équivalence de patch), puis un `git rebase origin/main` réel dans un worktree jetable. Le rebase écarte les commits dont le patch est déjà dans `main`.
3. Pour les rebases en conflit, j'ai mesuré le **résidu** avec la règle « la version de `main` prévaut sur chaque hunk en conflit », puis inspecté ce résidu à la main. Cette règle sert à mesurer ce qui reste ; elle ne tranche pas entre la branche et `main`.
4. Les branches d'archive ont été comparées fichier par fichier, et l'historique des PR a été lu par l'API GitHub.

Limites : l'équivalence de patch n'est pas une équivalence sémantique. Un résidu nul signifie que la branche n'ajoute plus rien à `main` sans conflit. Il ne dit pas que la version de `main` est la bonne. Ce registre est une photographie datée : reconsulter les références vivantes avant toute suppression.

## 1. PR ouvertes

| PR | Branche (tête) | État vérifié le 12 octobre | Action proposée |
|---|---|---|---|
| [#183](https://github.com/AntheaLiles/k7pl/pull/183) | `research/c-kernel-effective-rules-2026-10-12` (`64d98e7`) | **Fusionnée** le 12 octobre, après une CI complète verte (run [38293553896](https://github.com/AntheaLiles/k7pl/actions/runs/38293553896)). Elle contenait tout l'arbre de #170 : `git diff b055e38 9a1409a2` est vide. Noyau C3 compilé et audité (258 déclarations sous `Spec.C3.EffectiveKernel`). | Aucune. La porte C reste **NON SATISFAITE**. |
| [#170](https://github.com/AntheaLiles/k7pl/pull/170) | `research/c01-interface-ratification-2026-10-11` (`9a1409a`) | Tout son contenu est dans `main` depuis la fusion de #183. Elle est désormais en conflit avec `main` sur les épingles de `tests/python/test_stage_c_interface_audit.py`, que #183 a mises à jour. Par ailleurs, la fusion par rebase était impossible : trois commits de fusion (`0d575f7`, `a353c09`, `5de8d73`). | Fermer sans fusion, puis supprimer la branche. L'historique reste consultable via `refs/pull/170/head`. Ne pas réécrire la branche. |
| [#182](https://github.com/AntheaLiles/k7pl/pull/182) | `feat/semantic-navigation-rendered-links` (`cc415a4`) | Diff vide avec `main` : contenu intégré par #141, la tête est une fusion de `main`. | Fermer sans fusion, puis supprimer la branche. |
| [#184](https://github.com/AntheaLiles/k7pl/pull/184) | `rebase/feat/navigation-graph-mvp` (`be612be`) | **Fusionnée** le 12 octobre. Rebase sans conflit de `feat/navigation-graph-mvp` (`f24763a`) : approche « graphe dérivé du HTML rendu », à côté de `build_semantic_graph.py`. Aucun workflow ne l'appelle encore. | Supprimer `feat/navigation-graph-mvp` : ses deux fichiers sont identiques dans `main`. |
| [#185](https://github.com/AntheaLiles/k7pl/pull/185) | `rebase/split/pr10-1-outillage-spec` (`f2b17f1`) | Brouillon. Seul résidu de `split/pr10-1-outillage-spec` (`c4aea10`) : deux lignes de `writing-rules.md` documentant `{printindex}`, `{idx}` et `{gloss}`. | Fusionner ou fermer. Ensuite, supprimer les deux branches. |

## 2. Branches intégrées à `main` — rebase vide

Le rebase sur `main` ne laisse aucun changement. Ces branches peuvent être supprimées après votre vérification.

| Branche | Tête | Trace |
|---|---|---|
| `docs/semantic-navigation-model` | `5f2d9ce` | #137 fusionnée |
| `feat/c8-shared-statement-ontology` | `335faf3` | #130 fermée ; patchs présents dans `main` via #131 |
| `feat/figure-provenance-navigation` | `22aadf9` | #136 fusionnée |
| `feat/semantic-navigation-graph` | `d68ebaa` | #138 fusionnée |
| `feat/semantic-navigation-multi-slice` | `8957c46` | #144 fusionnée |
| `feat/tikz-figure-poc` | `710ca34` | #127 fusionnée |
| `feat/tikz-production-artifacts` | `b3dc217` | #135 fusionnée |
| `feat/tikz-production-integration` | `87c7201` | #133 fusionnée |
| `fix/semantic-graph-auto-width` | `83a1685` | #146 fusionnée |
| `fix/tikz-visual-fidelity` | `3684370` | #142 fusionnée |
| `fix/verso-figure-assets-html` | `d2cb684` | #124 fusionnée |
| `research/stage-c-interface-closure` | `ce686c0` | #154 fusionnée |
| `repair/pr54-coherence-2026-10-08` | `ebd08e7` | Aucune PR à ce nom. 86 commits d'avance : 78 sont équivalents à des commits de `main`, et les 8 autres deviennent vides au rebase. Tout le contenu est donc dans `main` ; seule la trajectoire des commits est propre à la branche. Cela corrige le statut « à conserver » du 11 octobre, qui reposait sur une comparaison non vérifiée fichier par fichier. |
| `feat/semantic-navigation-rendered-links` | `cc415a4` | Voir #182 |

## 3. Branches contenues dans #170 et #183

Ce sont les étapes empilées des décisions D3 à D11 et de l'audit indépendant de la porte C. Elles ont été fusionnées dans la pile de #170, pas dans `main`. `git cherry` contre la tête de #170 ne trouve aucun patch sans équivalent, sauf pour `research/l1-rel-mode-opportunities-2026-10-11` : ses deux patchs restants portent sur des fichiers que #170 reprend et révise (`L1-REL-MODE-OPPORTUNITIES-2026-10-11.md`, D-16 dans `DECISIONS.md`).

| Branche | Tête | PR (base) |
|---|---|---|
| `research/mode-scope-c01-c02-2026-10-11` | `ec7076f` | #171 (pile #170) |
| `research/d3-cost-budget-total-2026-10-11` | `5f9ef4c` | #172 |
| `research/d4-empty-sup-zero-2026-10-11` | `183f17d` | #173 |
| `research/d5-adm-principle-2026-10-11` | `bf8234f` | #174 |
| `research/d6-partial-consume-2026-10-11` | `18d7c88` | #175 |
| `research/d7-psi-independent-domain-2026-10-11` | `855fb23` | #176 |
| `research/d8-global-truncated-subtraction-2026-10-11` | `6d10441` | #177 |
| `research/d9-admissible-multiplicity-law-2026-10-11` | `6928e07` | #178 |
| `research/d10-restrict-multiplicity-law-2026-10-11` | `a322e33` | #179 |
| `research/d11-audit-multiplicity-sites-2026-10-11` | `37160f8` | #180 ; ancêtre direct de la tête de #170 |
| `research/c-gate-independent-audit-2026-10-11` | `596a957` | #181 |
| `research/l1-rel-mode-opportunities-2026-10-11` | `f1901f8` | aucune PR |

Action proposée : #183 étant fusionnée, ces branches peuvent être supprimées après votre vérification. Leur contenu est dans `main`.

## 4. Branches supersédées — aucun résidu utile

| Branche | Tête | Trace | Résidu après rebase |
|---|---|---|---|
| `ci/diagnostic-localization` | `e340d38` | #65 fermée | Nul : les trois fichiers sont en conflit avec la version ultérieure intégrée à `main` (problem matcher REUSE et son test). |
| `feat/c8-dependency-cycle-audit` | `ee658aa` | #87 fermée | Nul (`statement_inventory.py` a été remplacé par #91). |
| `feat/c8-statement-dependency-check` | `ea845ef` | #85 fermée | Nul. |
| `feat/lake-osv-scanning` | `ce6ace6` | #103 fermée, remplacée par #104 | Nul. |
| `tooling/prototypes-bcd` | `df200aa` | #25 fermée, remplacée par #26 | Nul. |
| `feat/c8-controlled-statement-migration-ci` | `da6c657` | #143 fermée, remplacée par #139 | Artefacts seulement : un paragraphe dupliqué dans `LEAN-STATEMENT-ONTOLOGY-IMPLEMENTATION.md`, la suppression d'un `import re` que `statement_inventory.py` utilise, et un fichier Verso entier collé au milieu d'une phrase de `SixSchemasDeMetatheorie.lean`. Rien à reprendre. |
| `feat/tikz-production-figures` | `030737e` | #132 fermée | Option `--check-tracked` de `check_tikz_poc.py`. Elle compare aux fichiers `spec/figures/<figure>.pdf` et `.svg`, que `main` ne versionne plus pour les figures TikZ depuis #135 : elle est obsolète. |
| `improvement-suggestions-c74e0` | `65e726b` | #27 fermée | Hybride incohérent avec `main` : 3 échecs de `scripts/ci/test_impact.py`, et perte du bit exécutable de `scripts/axiom-audit.sh`. Deux idées pourraient être reconçues, pas fusionnées : récupérer `axiom-audit` par SHA, et classer `scripts/axiom-audit.sh` parmi les déclencheurs du chemin complet. |

Action proposée : ces branches peuvent être supprimées après votre vérification. Aucune PR n'a été ouverte pour elles : elle serait vide, obsolète, ou ferait échouer la CI.

## 5. Branches à conserver — décision de l'autrice requise

Ces branches portent du contenu absent de `main` que je n'ai pas intégré : l'intégrer demanderait d'arbitrer une sémantique normative ou une migration sémantique.

### `claude/lean4-reuse-init-qvzlcg` (`d39d012`) — archive scientifique

La PR #10 a été fermée sans fusion. La branche contient un commit unique de 115 fichiers. Contenu absent de `main` :

- 13 comptes rendus de séances PR-02 numérotées 21 à 33 (5 au 7 octobre) ;
- 16 notes du dossier `analyses-decisions/` de l'ancien répertoire de recherche (index, `∥`/`vmap`, `spawn`, ANOM-18, singularités, sceaux, ARB-PR-04, ratifications, T-68) ;
- les études `etude-parallele-fourche-entrelacement` et `etude-spawn-fil-de-temps`, `instruction-des-decisions` et `t68-vocabulaire-en-bloc` ;
- les tables de renommage T-68 et les scripts `vocabulaire.py` et `t68_renommer.py` ;
- des modifications de `spec/`, de registres et d'outillage. Le rebase signale 36 conflits de contenu, de modification/suppression ou d'ajout/ajout, plus 34 conflits de localisation pour les fichiers ajoutés.

**Constat bloquant.** `main` contient déjà une **autre** série de séances « PR-02 21 à 62 », datée du 7 octobre (`docs/history/2026-10-07-pr-02-21-grade-architecture.md` et suivants). Les numéros 21 à 33 sont donc en collision avec des sujets différents : ce sont deux trajectoires PR-02 distinctes. De plus, les notes de recherche citent les anciens répertoires de suivi et de recherche d'avant la migration physique. `scripts/ci/check_documentation_architecture.py` refuse ces chemins hors de `docs/history`, `docs/archives` et `docs/migration`. Je n'ai donc produit ni rebase ni PR.

Options, sans choix de ma part :

- **A** : verser les comptes rendus 21 à 33 dans `docs/history/` sous un nom de série distinct. Ce renommage est une décision. Il faudrait ensuite rapprocher leurs conclusions de la matrice C-01 à C-09.
- **B** : garder la branche comme archive référencée (statut actuel).
- **C** : reprise sélective, note par note, après revue scientifique, dans un lot de `docs/migration/`.

### `split/pr10-2-troncature-conformite` (`99bc514`), `split/pr10-3-singularites` (`927a6fd`) et `split/pr10-4-manuscrit-semantique` (`b0d2cbf`)

Ces trois branches partagent le commit `c4aea10` de `split/pr10-1`, dont le seul résidu est repris par #185. Le reste de leur contenu est surtout normatif :

- **pr10-2** : §2.3 (troncature) et §6.2 (conformité), en conflit avec la version courante.
- **pr10-3** : singularités de la roue (`LesContraintesDeValeur.lean`), avec 56 lignes d'entrées bibliographiques, `scripts/controles/singularites.py` et `SpecBib.lean`. Cela relève de D/BLOQ-12, bloqué par la porte C. La partie non normative dépend de la partie normative, que je n'ai pas reprise.
- **pr10-4** : environ 30 fichiers `spec/`. 57 de ses 61 fichiers sont identiques à ceux de `claude/lean4-reuse-init-qvzlcg`.

Reprendre une partie de ce texte demande une décision d'autrice et, pour D, la clôture de la porte C. À conserver comme référence historique tant que cette décision n'est pas prise.

## 6. Branches créées par ce rapprochement

| Branche | Rôle |
|---|---|
| `rebase/feat/navigation-graph-mvp` | tête de #184 |
| `rebase/split/pr10-1-outillage-spec` | tête de #185 |
| `ccr-c4afa630-5uz1ic` | branche de session portant ce registre |

## Politique de nettoyage

1. Ce registre n'autorise aucun nettoyage massif. Chaque suppression reste une décision humaine, branche par branche.
2. Avant de supprimer une branche, revérifier sa tête : une tête différente de celle du tableau invalide la ligne.
3. Les branches de la section 5 restent conservées tant qu'une décision explicite de l'autrice n'est pas consignée dans [`DECISIONS.md`](DECISIONS.md).
4. Les branches de migration cumulative ne remplacent jamais les portes de sortie. En particulier, `split/pr10-3-singularites` ne permet pas de contourner l'étape C.
5. [`RECOVERY-STATUS-2026-10-11.md`](RECOVERY-STATUS-2026-10-11.md) reste un instantané daté ; il n'a pas été modifié.
