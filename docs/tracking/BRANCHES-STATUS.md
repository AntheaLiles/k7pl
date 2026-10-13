# Statut des branches de travail

**Rapprochement : 2026-10-12, sur `main` = `200b6935f5622e93d9add104e1f0e46dae6f6e6b`.**  
**État observé avant ce rapprochement :** 44 références de branche distantes (dont `main` et la branche de session `ccr-c4afa630-5uz1ic`) et trois PR ouvertes (#170, #182, #183).  
**Mises à jour du même jour :** #183 a été fusionnée (`ee0d05a`, arbre identique à sa tête), puis #184 et #185 (`main` = `96e1b1e`). Les branches `research/c-kernel-effective-rules-2026-10-12`, `rebase/feat/navigation-graph-mvp` et `rebase/split/pr10-1-outillage-spec` ont été supprimées à la fusion.

Ce registre remplace l'inventaire du 11 octobre. Il réalise le passage d'hygiène annoncé par [l'instantané de reprise du 11 octobre](https://github.com/AntheaLiles/k7pl/blob/f1d25e42ffb8badd62918f713142794a957aff4b/docs/tracking/RECOVERY-STATUS-2026-10-11.md), § 5 : pour chaque tête sans PR ouverte, il consigne s'il reste du contenu unique. Il recommande ; il **n'autorise ni fusion ni suppression**. Aucune branche n'a été supprimée ni réécrite pendant ce rapprochement. Les reprises sont portées par de nouvelles branches `rebase/…`, et les branches d'origine restent intactes.

## 0. Renommage `obsolete/` et `valuable/` (12 octobre 2026)

À la demande de l'autrice, chaque branche de travail a reçu un préfixe qui indique son sort :

- **`obsolete/<nom d'origine>`** : 34 branches qui n'apportent plus rien à `main`, sections 2 à 4 ci-dessous. Elles sont prévues pour suppression **après la fusion de la PR qui porte ce registre**. Cette PR restaure aussi le seul contenu encore unique de la pile `research/*` (voir section 3).
- **`valuable/<nom d'origine>`** : 5 branches à conserver : `claude/lean4-reuse-init-qvzlcg` et les quatre `split/pr10-*`, section 5. Pour `split/pr10-1-outillage-spec`, le préfixe suit la consigne « les `split/*` sont valuable » ; son commit `c4aea10` est aussi contenu dans `split/pr10-2`, `-3` et `-4`, et son seul résidu utile a été fusionné par #185.

Le nouveau nom pointe exactement sur le SHA indiqué dans les tableaux ; les 39 correspondances ont été vérifiées après création. Ne sont pas renommées : `main`, `ccr-c4afa630-5uz1ic` (tête de la PR de ce registre) et `automation/generated-status` (PR générée automatiquement).

**État au moment de l'écriture :** les nouveaux noms existent, mais **les anciens noms n'ont pas été supprimés**. La suppression a été refusée par le contrôle des actions destructives de la session de l'agent. Chaque branche existe donc provisoirement sous ses deux noms, sur le même commit. Supprimer un ancien nom ne perd aucun contenu, puisque le nouveau nom pointe sur le même SHA.

Dans les tableaux ci-dessous, les branches sont désignées par leur nom d'origine.

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
| [#185](https://github.com/AntheaLiles/k7pl/pull/185) | `rebase/split/pr10-1-outillage-spec` (`f2b17f1`) | **Fusionnée** le 12 octobre : le seul résidu de `split/pr10-1-outillage-spec` (`c4aea10`), deux lignes de `writing-rules.md` documentant `{printindex}`, `{idx}` et `{gloss}`. | Supprimer `split/pr10-1-outillage-spec`. Son commit reste contenu dans `split/pr10-2`, `-3` et `-4`. |

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

**Correction du 12 octobre.** L'équivalence de patch ne suffisait pas. Le commit de fusion `a353c09` de #170 a conservé l'ancienne version de deux registres de `docs/migration/`. Les consignations D3, D5, D6 et D7 de `L1-C01-C02-TYPED-INTERFACE-AUDIT-2026-10-11.md`, ainsi qu'une phrase de `L1-THEORY-OBJECTS.md`, manquaient donc à `main`. Le registre typé indiquait encore « D3 — OUVERT », alors que `DECISIONS.md` consigne D-17 à D-21. La PR de ce registre reporte à l'identique le résidu de `research/d11-audit-multiplicity-sites-2026-10-11` (`37160f8`), qui est aussi celui de `research/c-gate-independent-audit-2026-10-11`. Les résidus des autres branches de la pile en sont des versions antérieures.

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

Action proposée : ces branches peuvent être supprimées après la fusion de la PR de ce registre, qui contient la restauration ci-dessus.

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

**Revue contre les registres C (13 octobre 2026).** L'instantané de reprise du 11 octobre demandait de comparer les notes propres de cette archive aux registres C actuels avant toute décision. La revue a été faite en lecture seule, en quatre lots, sur `d39d012` comparé à `main` `489b082`. Registres consultés : `L1-THEORY-OBJECTS.md` et les audits `docs/migration/`, `DECISIONS.md`, le registre de migration C8, `fiches-statuts.csv`, `docs/history/`, `docs/research/` et `spec/`. Un échantillon de citations de chaque lot a été revérifié dans `main`. La revue classe les notes ; elle ne vaut ni preuve ni ratification, et ne recommande aucune des options ci-dessous.

| Lot | Fichiers de l'archive | Unité | Couvert | Partiel | Absent | Dépassé | Hors C | Autre |
|---|---|---|---|---|---|---|---|---|
| 1 | comptes rendus 21 à 33 ; `analyses-decisions/README.md`, `00-index-design.md`, `00-index-ratifications.md` | 16 fichiers | 0 | 11 | 1 | 3 | — | 1 non scientifique |
| 2 | `analyses-decisions/01` à `07` | 31 points | 2 | 10 | 10 | 6 | 3 | — |
| 3 | `analyses-decisions/ratifications-*` (5 notes) | 31 points | 5 | 16 | 7 | 2 | — | 1 non vérifié |
| 4 | études `∥` et `spawn`, `instruction-des-decisions.md`, notes et tables T-68, `t68_renommer.py`, `vocabulaire.py` | 48 points | 4 | 14 | 9 | 6 | 10 | 5 outillage |

Pour le lot 3, « couvert » signifie consigné à l'identique et « partiel », consigné autrement. « Hors C » renvoie aux étapes E (`∥`), F (`spawn`), D (singularités) et G2 (T-68). « Dépassé » : `main` porte un état ultérieur, auquel une reprise devrait confronter la note.

Constats transversaux :

- **Ce que `main` a déjà reçu.** Les 25 autres comptes rendus de l'archive sont dans `docs/history/` : 24 sont identiques à l'octet, le 15 ne diffère que par un chemin de lien. D'autres commits ont apporté la séance 28 (`5fa5634`), l'outillage d'index en français (`abd88ea`), `docs/research/sources-singularites.md` et `scripts/verif_singularites.py` (`b6683da`). Les autres modifications de `spec/` faites dans l'archive sont absentes : sur les lignes qu'elle ajoute, 0 sur 40 se retrouvent dans `AxiomatiqueGerminale.lean` et 11 sur 286 dans `SemantiqueOperationnelle.lean`. Ces modifications n'ont pas été revues une à une.
- **Une autre spécification.** Les notes décrivent la spécification de la trajectoire archive : elles citent des labels et des règles absents de `main` (`eq:reductions-orientees`, `eq:traduction-fils`, `thm:chaine_fils`, `thm:correspondance_niveaux`, règles `Nxt` et `Loc`) et les chemins d'avant la migration physique.
- **Décisions alléguées.** Aucune note n'est une preuve ni une ratification. Plusieurs présentent pourtant comme prises des décisions de l'autrice, souvent par des citations datées du 6 octobre, que `DECISIONS.md` ne consigne pas ou qu'il contredit (`D-7`). Elles sont listées dans [`DECISIONS.md`](DECISIONS.md), section « Décisions attribuées à l'autrice par l'archive, non consignées ».

Constats scientifiques de l'archive, absents des registres de `main` et **non vérifiés** ici ; chacun relève d'une instruction C avant toute reprise :

- `φ_n(ε) = ε^n` ne serait pas un morphisme de monoïde si l'effet est non commutatif, puisque `(εδ)^n ≠ ε^n δ^n` (séance 24, `instruction-des-decisions.md`). `spec/Spec/C3/ReglesDeTypage.lean`, l. 642–645 et 657, place `φ_n` dans `End_mon(ℰ)` ; la justification donnée, `φ_n ∘ φ_m = φ_{nm}`, porte sur la composition des `φ_n`. La revue n'a pas établi si `ℰ` est commutatif. Objets C-01, C-03, C-06.
- `at`, `wait` et `when` ne se réduisent pas sur un terme clos : les introductions temporelles sont des calculs, leurs éliminations attendent des valeurs (`spec/Spec/C3/GrammaireDesTermes.lean`, l. 33). Risque signalé pour `thm:progres` (séances 29 et 32, `instruction-des-decisions.md`). Objet C-07.
- `Λα.c` et le copatron manquent aux formes terminales de `thm:progres` ; les branches de `Guard` ne codent pas le message multiple (séance 29).
- La monotonie en `ℓ` serait fausse sur les types de fonction (`FACT-07`, séance 28).
- `spawn`, `send` et `guard` n'ont pas de traduction dans `thm:confinement_sortes` ; aucune clause ne couple `Spawn`, `Send` et `Move` ; `w` et `s` ne sont pas définis ; `Tick` est scalaire (analyses 02 et 03). Étapes F et C-07.

Contenus propres de l'archive, utilisables seulement si l'autrice choisit une reprise sélective (option C) :

- **Rédactions normatives non intégrées**, qui exigeraient un mandat : loi distributive et lemme d'indices (24) ; schémas de réduction (29, 31, 32) ; phases de 0 à 10 (32) ; §3.2 et singularités (31 à 33) ; `E_repro` « sur une machine » et topologie SPSC (31) ; ordre de préservation du §6.1 (22) ; phrases du guide de lecture pour `STRUCT-15` et `TRANS-08` (21, 25).
- **Pièces de recherche ou de suivi** : dossiers de conception (`00-index-design.md`) et verdicts sur 15 fiches, avec cinq questions de modèle (`00-index-ratifications.md`) ; grille V0 à V7 et carte des ambivalences de `∥` (E) ; options O1 à O4 et grille E1 à E10 pour `spawn` (F) ; tableau d'impacts de `∘` et `δ` (D) ; troisième relevé BIB (28) ; table codes et prémisses (17 sur 48) et table `TRANS-06` (32) ; hypothèses de module « `ℒ` fini » et « `⟦operation⟧` sans fil » (29).
- **Outillage T-68** : les collisions relevées restent vérifiables sur `main` (`at` pour deux formes, `open` et `unpack`). Les tables, `t68_renommer.py` et `vocabulaire.py` emploient les chemins d'avant la migration et leurs comptes sont faux sur `main`, qui compte 45 entrées (`docs/migration/L1-T68-AUDIT.md`).

Écarts internes à `main` relevés par la revue, **non corrigés** ici :

- `spec/Spec/C3/LesContraintesDeValeur.lean`, l. 403, écrit « en roues `1/0 = ⊥` » ; `docs/research/sources-singularites.md`, l. 39, donne `1/0 = ∞` d'après le résumé de Carlström. Quelle affirmation vaut reste à établir sur la source ; la correction toucherait `spec/` (voir `DECISIONS.md`).
- `docs/research/sources-singularites.md`, l. 50 et 55, et l'en-tête de `scripts/verif_singularites.py` disent la règle par réunion d'étiquettes écrite au manuscrit. Le Verso de `main` garde quatre singularités (`LesContraintesDeValeur.lean`, l. 366–368) : cette réécriture n'existe que dans l'archive.
- `ARB-PR-04` : `fiches-statuts.csv`, l. 125, et `FICHES-PR02.md`, l. 270, gardent « orientation B puis C à confirmer », alors que `DECISIONS.md` consigne une formulation remplacée.
- Signalé par le lot 1 mais non retenu après vérification : `PREUVE-08` « partielle » (`fiches-statuts.csv`, l. 63) est cohérent avec le registre C8, où `thm:troncature_comonade` est `under-review` avec preuve esquissée.

La branche reste conservée.

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
5. L'instantané de reprise du 11 octobre (`RECOVERY-STATUS-2026-10-11.md`) a été vérifié point par point le 13 octobre 2026, puis supprimé ; ses règles encore utiles sont dans [le plan maître](PROJECT-MASTER-PLAN.md) (§ 7 et X6). Dernière version : [`f1d25e4`](https://github.com/AntheaLiles/k7pl/blob/f1d25e42ffb8badd62918f713142794a957aff4b/docs/tracking/RECOVERY-STATUS-2026-10-11.md).
