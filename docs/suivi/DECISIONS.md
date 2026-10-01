# Décisions — ce qui est tranché, ce qui attend

**État au 1er octobre 2026.** Une ligne par décision. « Tranché » renvoie à la source qui le dit ; « à ratifier » veut dire qu'un compte rendu de séance l'a **appliquée** en suivant la recommandation du dossier, sans que l'auteur l'ait confirmée par écrit.

## Tranchées

| | Décision | Retenu | Source |
|---|---|---|---|
| `D-1` | périmètre du noyau formel (`ARB-PR-05`, `BLOQ-01`) | **voie 2 : formaliser la couche 2**, la thèse de sédimentation tenue entière | tranchée le 15 septembre ; [`taches-consolidees`](../relectures/pr-02/taches-consolidees.md) |
| — | les six décisions de conception du noyau (canal comme valeur, asynchrone primitif, sessions *et* boîtes aux lettres, graphe importé, localité graduée, coût en travail et profondeur) | arrêtées ; aucune quatrième place dans le jugement | [`journal/2026-09-30-pr-02-04`](../journal/2026-09-30-pr-02-04-couche-3-parallele.md) |
| `ARB-PR-01` | sens de la subsomption modale | pas d'inversion ; collision entre deux ordres | [`taches-consolidees`](../relectures/pr-02/taches-consolidees.md) §13 |
| `ARB-PR-02` | clause de taille | deux sortes de tailles 𝕊_μ / 𝕊_ν, jamais partagées | idem ; [`journal/2026-09-30-pr-02-01`](../journal/2026-09-30-pr-02-01-bloq-03-et-06.md) |
| `ARB-PR-05` | cadre d'ensemble du noyau minimal | **le cadre du manuscrit**, ratifié ; `FACT-21` et `-22` s'écartent | [`journal/2026-10-01-pr-02-07`](../journal/2026-10-01-pr-02-07-non-interference-et-fact.md) |
| — | pas de socle univalent pour les factorisations ; les factorisations tentantes et fausses se **documentent** (`REFUS`) plutôt qu'elles ne s'exécutent | [`factorisations-refusees.md`](factorisations-refusees.md) | [`plan de traitement`](pr-02-plan-de-traitement.md) §6 |

## À ratifier (appliquées, non confirmées)

| | Décision appliquée | À confirmer |
|---|---|---|
| `ARB-PR-03` | effets à portée : `ℰ_alg` et `ℰ_scoped` nommés, clôture **faible** sur le second, le monoïde ℳ gardé | que `BIB-01` (*Hefty Algebras*) reste non instruit tant que le besoin de modularité n'est pas établi |
| — | sept fermetures de fiches **déduites** (`PORT-08`, `PORT-16`, `REECR-02`, `-06`, `-07`, `-11`, `-25`) | `fiches-statuts.csv`, colonne `confiance` = `deduite` |
| `BLOQ-05` | niveau de production porté par l'effet (pas d'indexation du jugement) ; clauses sur `Op` et `Case` ; `Tick` en `⟨1, δ_ℓ̂⟩` ; aucune règle ajoutée (décomptes 49/45 inchangés) | que l'indexation `Δ ⊢^ℓ_𝒢` de la fiche n'est pas requise en plus, et que la sortie des niveaux de lecture par `Unbox`/`Var` n'a pas besoin de clause |

## Attendent une décision de l'auteur

| | Question | Éléments | Effet |
|---|---|---|---|
| `ARB-PR-07` / `D-2` | socle homotopique, ou famille modale et graduée ? | l'étude d'opportunité ([`etudes/etude-opportunite-hott`](../relectures/pr-02/etudes/etude-opportunite-hott.md)) conclut : famille modale et graduée, pour quatre motifs dont trois de fond ; **quatre imports ciblés** sont rentables (théorie de modes, calf et decalf, types gradués formalisés, récursion gardée multi-horloges) | écrire la décision et son motif au §1.2, « parce que la question sera reposée à chaque relecture » |
| — | les quatre imports ciblés : lesquels verser, où | « validés » d'après le compte rendu du 1er octobre, **non versés** au texte ; le dernier est écarté pour `BLOQ-06` (corrigé autrement) | trois instructions à conduire (`BIB-10` pour les modes) |
| `ARB-PR-06` | la revendication de préservation graduée de bout en bout est-elle un objectif déclaré ? | le manuscrit écrit « ce théorème n'est pas démontré » ; il est scellé `conjecture ⟨compilation⟩` | si oui, `PREUVE-02` passe en tête ; sinon la revendication est restreinte |
| `ARB-PR-04` | ce que le document promet pour le rejeu bit-à-bit | théorème scindé en rejeu logique et rejeu binaire sous `E_repro` (`proposition ⟨représentation⟩`) ; hypothèse d'injectivité observation/représentation | la décision de fond reste à écrire |
| `T-68` | choix des mots pour les quarante-quatre primitives | [`primitives.md`](primitives.md) : chaque entrée porte ses candidats et le motif de l'écart | vocabulaire du langage avant implémentation |

## Nouvelles, nées de la conversion

| | Question | Recommandation |
|---|---|---|
| `D-5` ✅ | **où écrire pendant la finition ?** | **Tranchée le 1er octobre 2026 : le Verso fait foi**, les fichiers Org sont archivés ; les contrôles sont portés (`scripts/controle.py`) |
| `D-6` ✅ | sous-titre du document | le sous-titre du manuscrit, « A functional layered programming language », fait foi (`ANOM-16`) ; le dépôt n'en porte aucun |
| `D-7` | annexes B, C, D squelettiques ([`ANOM-04`](ANOMALIES.md)) | décider avant la première release |
| `D-8` | rétablir au glossaire les trois couches ([`ANOM-06`](ANOMALIES.md)) | oui : le corps du document les définit, le glossaire doit suivre |
| `D-9` | première release `spec-v0.1.0` : quand ? | après les portes P1 à P5 du [tableau de bord](TABLEAU-DE-BORD.md) |

## Ce qui n'a pas été rapproché

Le **programme d'ajustement de septembre** ([`todo-manuscrit`](../historique/2026-09-02-todo-manuscrit.md), 115 items en trois blocs) porte ses items comme « faits » ou « tranchés » ; les **questions de recherche** ([`questions`](../recherche/questions.md)) sont closes à 224 sur 225 (la seule en cours demande si les cônes intégrables portent une exponentielle graduée sur ℛ). Je n'ai pas rapproché ces items un à un du manuscrit courant : le suivi les dit clos, et la campagne PR-02 a depuis réécrit une grande partie des passages concernés. Un rapprochement ciblé se justifie pour les items qui touchent les énoncés repris sous concurrence (blocs A et C) ; il est proposé comme première relecture d'ensemble.
