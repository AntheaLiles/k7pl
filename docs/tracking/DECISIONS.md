# Décisions — ce qui est tranché, ce qui attend

**État de synthèse au 11 octobre 2026 ; les dates historiques restent indiquées par entrée.** Une ligne par décision. « Tranché » renvoie à la source qui le dit ; « à ratifier » veut dire qu'un compte rendu de séance l'a **appliquée** en suivant la recommandation du dossier, sans que l'autrice l'ait confirmée par écrit.

## Tranchées

| | Décision | Retenu | Source |
|---|---|---|---|
| `D-1` | périmètre du noyau formel (`ARB-PR-05`, `BLOQ-01`) | **voie 2 : formaliser la couche 2**, la thèse de sédimentation tenue entière | tranchée le 15 septembre ; [`taches-consolidees`](../peer-review/pr-02/taches-consolidees.md) |
| — | les six décisions de conception du noyau (canal comme valeur, asynchrone primitif, sessions *et* boîtes aux lettres, graphe importé, localité graduée, coût en travail et profondeur) | arrêtées ; aucune quatrième place dans le jugement | [`journal/2026-09-30-pr-02-04`](../history/2026-09-30-pr-02-04-couche-3-parallele.md) |
| `ARB-PR-01` | sens de la subsomption modale | pas d'inversion ; collision entre deux ordres | [`taches-consolidees`](../peer-review/pr-02/taches-consolidees.md) §13 |
| `ARB-PR-02` | clause de taille | deux sortes de tailles 𝕊_μ / 𝕊_ν, jamais partagées | idem ; [`journal/2026-09-30-pr-02-01`](../history/2026-09-30-pr-02-01-bloq-03-et-06.md) |
| `ARB-PR-05` | cadre d'ensemble du noyau minimal | **le cadre du manuscrit**, ratifié ; `FACT-21` et `-22` s'écartent | [`journal/2026-10-01-pr-02-07`](../history/2026-10-01-pr-02-07-non-interference-et-fact.md) |
| — | pas de socle univalent pour les factorisations ; les factorisations tentantes et fausses se **documentent** (`REFUS`) plutôt qu'elles ne s'exécutent | [`factorisations-refusees.md`](factorisations-refusees.md) | [`plan de traitement`  ](../history/pr-02-plan-de-traitement.md) §6 |

## Tranchées le 1er octobre 2026 (suite)

| | Décision | Retenu | Effet |
|---|---|---|---|
| `ARB-PR-07` / `D-2` | socle homotopique ou famille modale et graduée | **famille modale et graduée** ; imports ciblés instruits un à un | motif écrit au §1.2 (guide de lecture) |
| `ARB-PR-06` | préservation graduée de bout en bout | **objectif déclaré** : la revendication devient une preuve, sans dénaturer le projet (passe par passe, fragment monomorphisé d'abord) | `PREUVE-02` en tête ; énoncé écrit au §6.2 ; reste conjecture jusqu'à la preuve |
| `split/pr10-1-outillage-spec` | Le travail historique sur `{printindex}` est abandonné pour la branche courante : son mécanisme est remplacé par la liste canonique `tools/SpecExt/IndexTerms.lean` et l'indexation actuelle ; aucune fusion de cette branche n'est requise. | index / provenance |
| `ARB-PR-04` | promesse générale du rejeu bit-à-bit | **formulation historique remplacée** : rejeu logique sémantique ; identité bit-à-bit conditionnée au profil de représentation Π | décision postérieure ci-dessous ; conserver l'instruction historique comme provenance |
| `T-68` | mots des 44 primitives | **avant-dernier** dans l'ordre de finition (avant la release) | [`primitives.md`](primitives.md) |
| — | annexe E | **fondue dans le manuscrit** : grammaires et règles au ch. 3, sémantique et sortes au ch. 4, table des glyphes au ch. 1 | `STRUCT-23` ; [journal](../history/2026-10-01-pr-02-15-fusion-annexe-e.md) |
| `D-9` ✅ | première release `spec-v0.1.0` : quand ? | **porte P6**, après P1 à P5 : tranchée le 1er octobre 2026 |
| — | `BLOQ-05` (indexation du jugement non requise), les deux options de `BLOQ-07` | validées le 1er octobre ; réévaluées avec l'ensemble une fois tout traité | — |

## À ratifier (appliquées, non confirmées)

| `QA-28` | réouverture de la question sur les quatre composantes du grade | **à nouveau en revue** : l'élision reste admise comme convention de présentation, mais l'action scalaire et la séparation grade/modes restent à établir | décision d'auteur du 7 octobre 2026, reprise dans PR #54 |
| `ARB-PR-04` / PR-54 | statut épistémique des résultats de cohérence | **à confirmer par l'autrice** : `thm:coherence_axiome`, `thm:action_parallele`, `thm:morphismes_modes` et `thm:substitution` restent des propositions ; `thm:coherence_usage` est une proposition distincte. La PR #54 est fusionnée, mais sa fusion ne vaut pas ratification scientifique des statuts. | [PR #54 fusionnée le 8 octobre](https://github.com/AntheaLiles/k7pl/pull/54), séances C des 7–8 octobre 2026 |

| | Décision appliquée | À confirmer |
|---|---|---|
| `ARB-PR-03` | effets à portée : `ℰ_alg` et `ℰ_scoped` nommés, clôture **faible** sur le second, le monoïde ℳ gardé | que `BIB-01` (*Hefty Algebras*) reste non instruit tant que le besoin de modularité n'est pas établi |
| — | sept fermetures de fiches **déduites** (`PORT-08`, `PORT-16`, `REECR-02`, `-06`, `-07`, `-11`, `-25`) | `fiches-statuts.csv`, colonne `confiance` = `deduite` |

## Attendent une décision de l'auteur

| | Question | Éléments | Effet |
|---|---|---|---|
| — | les quatre imports ciblés : lesquels verser, où | « validés » d'après le compte rendu du 1er octobre, **non versés** au texte ; le dernier est écarté pour `BLOQ-06` (corrigé autrement) | trois instructions à conduire (`BIB-10` pour les modes) |

## Nouvelles, nées de la conversion

| | Question | Recommandation |
|---|---|---|
| `D-5` ✅ | **où écrire pendant la finition ?** | **Tranchée le 1er octobre 2026 : le Verso fait foi**, les fichiers Org sont archivés ; les contrôles sont portés (`scripts/controle.py`) |
| `D-6` ✅ | sous-titre du document | le sous-titre du manuscrit, « A functional layered programming language », fait foi (`ANOM-16`) ; le dépôt n'en porte aucun |
| `D-7` | annexes B, C, D squelettiques ([`ANOM-04`](ANOMALIES.md)) | décider avant la première release |
| `D-8` | rétablir au glossaire les trois couches ([`ANOM-06`](ANOMALIES.md)) | oui : le corps du document les définit, le glossaire doit suivre |
| `D-9` ✅ | première release `spec-v0.1.0` : quand ? | **porte P6**, après P1 à P5 : tranchée le 1er octobre 2026 |

## Décisions postérieures au 1er octobre 2026

| Sujet | Décision / état courant | Portée |
|---|---|---|
| Extraction B/C/D | Les lots d'extraction documentaire sont portés par `docs/migration/` ; ils qualifient et extraient le corpus sans réécrire les sources historiques. | migration sémantique |
| `ARB-PR-04` | Le rejeu logique reste sémantique ; le rejeu bit-à-bit relève de la conformité au profil de représentation. | assurance / conformance |
| `D8` | La passe physique de documentation est clôturée ; les décisions de migration restantes relèvent de `docs/migration/`. | architecture documentaire |
| `P1–P6` | Les portes restent la séquence de release : P1 blocages scientifiques, P2 assertions ouvertes, P3 décisions auteur, P4 implémentation, P5 stabilisation documentaire, P6 release. | release |

## État scientifique C — mise à jour du 11 octobre 2026

| Sujet | État établi par les registres | Ce qui reste ouvert |
|---|---|---|
| Livraison PR #54 | Fusionnée le 8 octobre 2026 et intégrée à main ; aucune action de revue/fusion de cette PR ne reste à faire. | Cette livraison ne ferme pas l'étape scientifique C et n'autorise pas D–F. |
| Grade / exponentielle / coût (séances 59–62) | L'exploration de conception est bornée ; les séances enregistrent une interface de référence pour π_U, Scale_Usage, φ_n, conversions, W/D et le coût scalaire. | La source normative C2 marque encore π_U et Scale_Usage comme candidats et écrit Cost_Budget comme fonction partielle alors que max(W,D) est présenté sans restriction de domaine. L'autrice doit ratifier la promotion et préciser totalité/partialité ; les lois de coerce, w/c, substitution et ψ restent ouvertes. Voir le [registre des objets C](../migration/L1-THEORY-OBJECTS.md). |
| When / P3 | Les notes de conception retiennent une admissibilité différée au passage d'effet via ψ ; le coût non borné est rendu explicite et testé par Adm. | Ratifier l'interprétation normative de P3 si aucune confirmation explicite n'est déjà enregistrée ; la preuve de correction de ressource reste distincte. |
| Sim / PREUVE-07 | Simulation avant, distincte de la préservation de typage et de la traduction syntaxique ; l'énoncé narratif reste ouvert. | Clauses de traduction effet/temps, invariant du canal chaîné, cas de réduction et relation d'observation cible ; pas d'inférence de bisimulation ou de pleine abstraction. |
| Mémoire H1/H2/H3 | La revue enregistre une circularité argumentative potentielle pour H1, pas un cycle syntaxique ; H2 et H3 sont des obligations séparées. | H1 doit être prouvée indépendamment ou conservée comme hypothèse avec portée explicite ; prouver H2 et H3 dans leurs contrats respectifs. |

**Règle épistémique.** Les séances 59–62 établissent la provenance des choix de conception, non la vérité des lois mathématiques correspondantes. Les fichiers Verso/Lean qui affichent des blocs d'énoncé et des esquisses ne sont pas, de ce seul fait, des preuves Lean vérifiées. Un résultat de build n'autorise ni la promotion d'une proposition au statut établi ni l'intégration normative de D, E ou F.

## Ce qui n'a pas été rapproché

Le **programme d'ajustement de septembre** ([`todo-manuscrit`](../history/2026-09-02-todo-manuscrit.md), 115 items en trois blocs) porte ses items comme « faits » ou « tranchés » ; les **questions de recherche** ([`questions`](../research/questions.md)) sont closes à 224 sur 225 (la seule en cours demande si les cônes intégrables portent une exponentielle graduée sur ℛ). Je n'ai pas rapproché ces items un à un du manuscrit courant : le suivi les dit clos, et la campagne PR-02 a depuis réécrit une grande partie des passages concernés. Un rapprochement ciblé se justifie pour les items qui touchent les énoncés repris sous concurrence (blocs A et C) ; il est proposé comme première relecture d'ensemble.


| D-10 | DOI Zenodo `10.5281/zenodo.23040451` | **Ne pas l'utiliser implicitement comme concept de publication.** Son rôle exact (concept/version et contenu archivé) doit être vérifié humainement sur Zenodo. Le flux de release utilisera explicitement `ZENODO_CONCEPT_RECID` ; `NEW` est réservé à une création volontaire d'un nouveau concept. | `docs/PROVENANCE.md`, `scripts/sync_zenodo.py` |
| D-11 | type de publication du PDF Zenodo | **`technicalnote`** pour le dépôt du PDF ; `zenodo.json` et `zenodo.files.json` sont alignés. | métadonnées de release |
| D-12 | revendication de conformance publique | **Aucune conformance spécification–implémentation n'est revendiquée tant que le couplage n'est pas établi.** Lean contrôle la spécification et ses obligations formelles ; l'implémentation existe séparément. | `CITATION.cff`, `zenodo.json`, `zenodo.files.json`, `docs/ASSURANCE.md` |
| D-13 | badge fair-software | **Badge manuel à 4 critères sur 5**, le critère de registre étant explicitement hors sujet dans `.howfairis.yml`. Le score affiché n'est pas présenté comme un calcul automatique. | `README.md`, `.howfairis.yml` |


| D-14 | hygiène des branches | Audit du 8 octobre : les branches historiques sont désormais classées dans `docs/tracking/BRANCHES-STATUS.md`. `claude/lean4-reuse-init-qvzlcg` est conservée comme archive scientifique non normative car elle contient encore du matériau absent de `main`. `split/pr10-1-outillage-spec` est explicitement abandonnée. La branche `automation/generated-status` et sa PR #71 sont supersédées par #72. |


## D-15 — Outils Lean d'assurance de conformité de projet (question ouverte, 2026-10-10)

**État : à instruire ; aucune décision d'implémentation prise.** L'issue [#122](https://github.com/AntheaLiles/k7pl/issues/122) ouvre l'exploration.

La question est de déterminer si Lean apporte une valeur spécifique pour relier des contraintes de projet (normes, contrats, règles métier, décisions et exigences) à des propriétés vérifiables et à des preuves de réalisation. Il faut distinguer les théorèmes vérifiés, les contrôles de données, la traçabilité, les observations empiriques et les jugements humains responsables. Une formalisation ou une compilation réussie ne suffit pas à établir une conformité juridique, contractuelle ou organisationnelle.

Avant toute implémentation, l'étude doit comparer Lean à des solutions plus simples, définir une revendication d'assurance bornée et proposer un démonstrateur non critique avec des contre-exemples. Elle n'autorise aucune modification implicite de la spécification normative ou de l'implémentation Lean de K7PL.
