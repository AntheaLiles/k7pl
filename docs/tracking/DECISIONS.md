# Décisions — ce qui est tranché, ce qui attend

**État au 1er octobre 2026.** Une ligne par décision. « Tranché » renvoie à la source qui le dit ; « à ratifier » veut dire qu'un compte rendu de séance l'a **appliquée** en suivant la recommandation du dossier, sans que l'auteur l'ait confirmée par écrit.

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
| `ARB-PR-04` | promesse du rejeu bit-à-bit | **à instruire** avant de trancher | [`instruction-arb-pr-04-rejeu-binaire`](../research/instruction-arb-pr-04-rejeu-binaire.md) |
| `T-68` | mots des 44 primitives | **avant-dernier** dans l'ordre de finition (avant la release) | [`primitives.md`](primitives.md) |
| — | annexe E | **fondue dans le manuscrit** : grammaires et règles au ch. 3, sémantique et sortes au ch. 4, table des glyphes au ch. 1 | `STRUCT-23` ; [journal](../history/2026-10-01-pr-02-15-fusion-annexe-e.md) |
| `D-9` ✅ | première release `spec-v0.1.0` : quand ? | **porte P6**, après P1 à P5 : tranchée le 1er octobre 2026 |
| — | `BLOQ-05` (indexation du jugement non requise), les deux options de `BLOQ-07` | validées le 1er octobre ; réévaluées avec l'ensemble une fois tout traité | — |

## À ratifier (appliquées, non confirmées)

| `QA-28` | réouverture de la question sur les quatre composantes du grade | **à nouveau en revue** : l'élision reste admise comme convention de présentation, mais l'action scalaire et la séparation grade/modes restent à établir | décision d'auteur du 7 octobre 2026, reprise dans PR #54 |
| `ARB-PR-04` / PR-54 | statut des résultats de cohérence | ratification : `thm:coherence_axiome`, `thm:action_parallele`, `thm:morphismes_modes` et `thm:substitution` sont des propositions ; `thm:coherence_usage` est une proposition distincte | PR #54, séance C des 7–8 octobre 2026 |

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

## Ce qui n'a pas été rapproché

Le **programme d'ajustement de septembre** ([`todo-manuscrit`](../history/2026-09-02-todo-manuscrit.md), 115 items en trois blocs) porte ses items comme « faits » ou « tranchés » ; les **questions de recherche** ([`questions`](../research/questions.md)) sont closes à 224 sur 225 (la seule en cours demande si les cônes intégrables portent une exponentielle graduée sur ℛ). Je n'ai pas rapproché ces items un à un du manuscrit courant : le suivi les dit clos, et la campagne PR-02 a depuis réécrit une grande partie des passages concernés. Un rapprochement ciblé se justifie pour les items qui touchent les énoncés repris sous concurrence (blocs A et C) ; il est proposé comme première relecture d'ensemble.
