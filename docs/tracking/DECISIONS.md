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
| `D-7` | périmètre éditorial des annexes B/C/D ([`ANOM-04`](ANOMALIES.md)) | **OUVERT — décision de l'autrice requise.** Choisir développer séparément, regrouper comme annexe d'outillage, ou différer hors du document normatif. L'absence actuelle des modules B/C/D de `spec/` et la conservation des prototypes dans `tooling/prototypes-bcd/` sont des faits d'arborescence, pas une ratification de l'option de différer. Voir [`L1-ANNEXES-EXTRACTION.md`](../migration/L1-ANNEXES-EXTRACTION.md). |
| `D-8` | rétablir au glossaire les trois couches ([`ANOM-06`](ANOMALIES.md)) | oui : le corps du document les définit, le glossaire doit suivre |
| `D-9` ✅ | première release `spec-v0.1.0` : quand ? | **porte P6**, après P1 à P5 : tranchée le 1er octobre 2026 |

## Décisions postérieures au 1er octobre 2026

| Sujet | Décision / état courant | Portée |
|---|---|---|
| Extraction B/C/D | Les lots d'extraction documentaire sont portés par `docs/migration/` ; ils qualifient et extraient le corpus sans réécrire les sources historiques. | migration sémantique |
| `ARB-PR-04` | Le rejeu logique reste sémantique ; le rejeu bit-à-bit relève de la conformité au profil de représentation. | assurance / conformance |
| `D8` | La passe physique de documentation est clôturée ; les décisions de migration restantes relèvent de `docs/migration/`. | architecture documentaire |
| ANOM-09 | **Résolution technique vérifiée sur candidate** `9c34e7aaa99e00809c00d56812ab2160b55c276d`, run CI [`38131422345`](https://github.com/AntheaLiles/k7pl/actions/runs/38131422345): index paginé aux pp. imprimées 277–278, 287 pages, cadres rouges supprimés, aucune cible `idx-*` non résolue dans `main.log`, garde CI dédiée réussie. Cette clôture concerne ANOM-09 sur la candidate, pas la validation globale L1/L5. | rendu PDF / test / CI |
| `P1–P6` | Les portes restent la séquence de release : P1 blocages scientifiques, P2 assertions ouvertes, P3 décisions auteur, P4 implémentation, P5 stabilisation documentaire, P6 release. | release |

## État scientifique C — mise à jour du 11 octobre 2026

| Sujet | État établi par les registres | Ce qui reste ouvert |
|---|---|---|
| Livraison PR #54 | Fusionnée le 8 octobre 2026 et intégrée à main ; aucune action de revue/fusion de cette PR ne reste à faire. | Cette livraison ne ferme pas l'étape scientifique C et n'autorise pas D–F. |
| Grade / exponentielle / coût (séances 59–62) | Les interfaces `π_U`, `Bang_𝒢` et `Scale_Usage` sont ratifiées ; D3–D8 fixent les contrats de `Cost_Budget`, `Adm`, `Consume` et de soustraction prolongée. La branche PR #170 contient maintenant des modèles Lean partiels pour l’action d’usage, les agrégateurs de coût, les permissions modales, le contrat budgétaire `When` et les invariants abstraits de mémoire. | La cohérence des conversions/comonade, la substitution exhaustive, la correction de ressource sur les règles, la simulation, H3, le raccord aux mesures opérationnelles et l’audit complet D11 restent ouverts. C demeure NON SATISFAITE. Voir le [registre des objets C](../migration/L1-THEORY-OBJECTS.md) et le [dossier d’intégration source](../migration/L1-C-SOURCE-INTEGRATION-2026-10-12.md). |
| When / P3 | **P3-B ratifiée par l'autrice le 11 octobre 2026** : l'attente environnementale est une latence de surveillance de l'orchestrateur ; elle ne s'impute pas au coût d'exécution de l'automate déclenché. | Formaliser la séparation latence/coût d'exécution, le rôle de l'orchestrateur et le contrat budgétaire de l'automate ; la preuve de correction de ressource reste à produire. |
| Discipline budgétaire / option C | **Orientation ratifiée pour instruction le 11 octobre 2026** : budgets validés à la compilation, exécution de l'automate tenue dans les bornes, garde-fous modulés par couche K7PL. | Définir le contrat par couche et prouver la correction entre validation statique et exécution réelle ; les garde-fous ne remplacent pas la preuve ; aucune signature n'est encore fixée. |
| Sim / PREUVE-07 | Simulation avant, distincte de la préservation de typage et de la traduction syntaxique ; l'énoncé narratif reste ouvert. | Clauses de traduction effet/temps, invariant du canal chaîné, cas de réduction et relation d'observation cible ; pas d'inférence de bisimulation ou de pleine abstraction. |
| Mémoire H1/H2/H3 | La revue enregistre une circularité argumentative potentielle pour H1, pas un cycle syntaxique ; H2 et H3 sont des obligations séparées. | H1 doit être prouvée indépendamment ou conservée comme hypothèse avec portée explicite ; prouver H2 et H3 dans leurs contrats respectifs. |

### Décision d'autrice — P3-B / When (11 octobre 2026)

**Décision ratifiée.** `when` est un déclencheur réactif : il surveille l'environnement et lance une séquence d'actions lorsqu'un événement survient. Contrairement à `case`, qui filtre des conditions (type, expression régulière, etc.), `when` exprime une attente d'événement. L'autrice retient P3-B : une attente environnementale, même de durée non bornée, relève de l'orchestrateur qui agrège les surveillances connues et lance les automates ad hoc ; elle ne doit pas être imputée au coût d'exécution de l'automate déclenché.

**Rationale.** L'événement peut ne jamais survenir dans un temps fini. Cette possibilité doit rester visible comme latence de surveillance sans être confondue avec les ressources consommées par l'automate une fois lancé. La séparation évite d'attribuer au calcul conditionné par `when` un temps d'exécution antérieur à son déclenchement.

**Portée.** Cette décision fixe l'intention normative de P3 pour `when`. Elle ne ratifie pas une représentation mathématique particulière de la latence (coordonnée distincte, projection ou autre interface typée), ni une politique complète d'ordonnancement, de concurrence, de réarmement ou d'équité de l'orchestrateur.

**Conséquences et limites.** Le modèle devra rendre séparément observable la latence et contrôler le coût d'exécution propre à l'automate déclenché. Il reste à définir la frontière formelle du déclenchement, les budgets respectifs, les paramètres et le domaine de `ψ`, la précondition `Adm`, le résultat `Consume`, la scalarisation de coût et la compatibilité avec les règles de composition et la substitution. Aucune modification de `spec/` ou de `src/` n'est effectuée par cette ratification documentaire ; C-04 et la porte C demeurent ouverts.

### Décision d'autrice — discipline budgétaire et garde-fous (11 octobre 2026)

**Orientation ratifiée pour instruction : option C.** Les budgets doivent être validés lors de la compilation. L'exécution de l'automate déclenché doit se résoudre dans les bornes budgétées. Les mécanismes complémentaires sont des garde-fous, et leur rôle doit être modulé selon la couche K7PL concernée.

**Rationale.** La vérification statique porte l'engagement principal de conformité aux budgets ; les protections additionnelles ne doivent ni remplacer cette validation ni masquer un dépassement. Comme les couches K7PL n'ont pas nécessairement les mêmes objets, opérations ni garanties temporelles, le principe doit être décliné et justifié couche par couche plutôt que codé comme une règle uniforme sans preuve.

**Portée.** Cette ratification retient l'option C comme orientation de conception et de recherche, pas comme un contrat formel entièrement défini. Elle ne fixe ni les métriques de budget par couche, ni la sémantique exacte de la validation à la compilation, ni les garde-fous d'exécution, ni les relations de composition entre budgets.

**Obligations ouvertes.** Définir ce que signifie validation de budget à la compilation pour chaque couche ; préciser les bornes et les observables ; démontrer un théorème de correction reliant l'acceptation statique au comportement effectif de l'automate sous ses hypothèses ; distinguer cette preuve des garde-fous d'exécution, de leur portée et de leurs modes de défaillance ; prouver la composition des coûts inter-couches. Jusqu'à ce que ces éléments soient typés et prouvés, le principe ne prouve pas par lui-même que l'exécution respecte les budgets. Aucun changement normatif dans spec/ ou src/ n'est effectué par cet enregistrement.

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

## D-16 — Périmètre des modes et piste Rel (11 octobre 2026)

Décision de périmètre : les trois modes de référence de la sédimentation actuelle sont M_Lin (couche 1), M_Aff (couche 2) et M_Unr (couche 3). Leur sélection architecturale est retenue ; leurs lois, le contrat des morphismes et leur réalisation par les règles restent à normaliser et à prouver. Rel n'est pas activé dans la grammaire ni dans les règles génératrices actuelles. La piste est documentée dans [L1-REL-MODE-OPPORTUNITIES-2026-10-11.md](../migration/L1-REL-MODE-OPPORTUNITIES-2026-10-11.md).

Distinction requise : U_Rel=[1..ω] est un intervalle d'usage, tandis que M_Rel=(𝓡,𝓡,false) est un triplet structurel candidat ; l'un ne définit pas l'autre. C2 décrit les branches M_Lin → M_Aff → M_Unr et M_Lin → M_Rel → M_Unr, avec Aff et Rel incomparables. Ce diamant candidat n'établit ni que les règles actuelles réalisent Rel ni que son activation soit requise. Cette décision de périmètre ne constitue pas une preuve et ne ferme pas C-02 ou la porte C.


## D-17 — Totalité du coût budgétaire (11 octobre 2026)

**Décision d’autrice :** `Cost_Budget : K → 𝔅` est totale sous les hypothèses et conventions explicites qui rendent `W`, `D` et `max` bien définis, avec `Cost_Budget(κ)=max(W(κ),D(κ))`. Cette ratification résout le choix total/partiel de la fonction de coût ; elle ne constitue pas une preuve de ses propriétés.

**D4 — Supremum sur domaine vide : DÉCIDÉ.** Le 11 octobre 2026, l’autrice ratifie l’option A : `ℒ=∅` est autorisé et `sup ∅=0` dans `ℕ∞`. Ainsi `D(κ)=0` lorsque `ℒ=∅`. Cette convention ne remplace pas la définition canonique de `K` ni la preuve Lean des agrégats ; elle ne prouve aucune loi de composition ou de sûreté budgétaire. Voir la [note D4](../migration/L1-D4-EMPTY-SUPREMUM-2026-10-11.md). `Adm` reste un prédicat d’admissibilité ; `Consume` et `ψ` peuvent être partielles selon leurs propres domaines et préconditions. Restent ouvertes les preuves de définition correcte de `W`/`D`, de composition du coût, de cohérence avec la consommation d’un effet et de respect effectif des bornes à l’exécution. Voir la [note D3](../migration/L1-D3-COST-BUDGET-RATIFICATION-2026-10-11.md).


## D-18 — Convention de supremum vide (11 octobre 2026)

**Décision d’autrice :** `ℒ=∅` est autorisé et `sup ∅=0` dans `ℕ∞`. En conséquence, `D(κ)=sup_{ℓ∈ℒ}s_ℓ=0` lorsque l’ensemble des niveaux est vide. Cette convention complète la ratification D3 de la totalité de `Cost_Budget`, sous réserve que les domaines et codomaines canoniques soient définis de façon cohérente.

La décision ne constitue pas une définition formelle de `K`, ni une preuve Lean de `W`, `D` ou `Cost_Budget`. Restent ouvertes la formalisation des agrégats, les lois de composition invoquées, le lien entre coût annoncé et budget consommé, et la preuve de respect des bornes à l’exécution. Voir la [note D4](../migration/L1-D4-EMPTY-SUPREMUM-2026-10-11.md).


## D-19 — Principe d’admissibilité du budget (11 octobre 2026)

**Décision d’autrice : principe de couverture ratifié ; forme canonique normalisée.** Un budget `β` est admissible lorsque `Cost_Budget(κ)≤β`. Dans `ℕ∞`, si `ω` est le maximum, la formulation `β=ω ∨ Cost_Budget(κ)≤β` lui est logiquement équivalente ; retenir la seule comparaison est une normalisation logique, pas une nouvelle ratification d’autrice.

Le lemme Lean `K7pl.GradeBudget.top_disjunct_iff_le` vérifie seulement l’identité d’ordre dans `ℕ∞` ; il ne définit ni `Cost_Budget`, ni le prédicat formel K7PL `Adm`, ni leurs usages dans les règles. La définition formelle des types et de l’ordre, la formalisation de `Cost_Budget`, la preuve de correction et l’usage de cette précondition dans chaque règle restent ouverts. Cette décision ne détermine pas le domaine de `Consume` (D6) ni celui de `ψ` (D7). Voir [la note D5](../migration/L1-D5-ADM-PRINCIPLE-2026-10-11.md).


## D-20 — Domaine partiel de `Consume` (11 octobre 2026)

**Décision d’autrice : option A.** `Consume(β,κ)` est une opération partielle, définie seulement lorsque `Adm(β,κ)` est satisfaite ; sur ce domaine, sa valeur retenue est `β ⊖ Cost_Budget(κ)`. D8 ratifie globalement la convention `ω ⊖ ω = ω`. Restent à prouver les propriétés de l’opération requises par les règles et le raccord entre admissibilité, coût annoncé et consommation.

D6 fixe le domaine partiel de `Consume`, tandis que D8 ratifie séparément la convention globale de soustraction tronquée, dont `ω ⊖ ω = ω` ; D7 traite indépendamment le domaine de `ψ`. Restent à formaliser les signatures/types canoniques et à prouver que, dans chaque règle où une consommation est requise, l’admissibilité précède la consommation et la borne résultante correspond au coût annoncé. Aucun théorème de correction de ressource n’est revendiqué. Voir la [note D6](../migration/L1-D6-CONSUME-PARTIAL-DOMAIN-2026-10-11.md) et la [note D8](../migration/L1-D8-GLOBAL-TRUNCATED-SUBTRACTION-2026-10-11.md).


## D-21 — Domaine de ψ indépendant de Consume (11 octobre 2026)

**Décision d’autrice : option B.** Le domaine de `ψ` est conceptuellement indépendant de la définissabilité de `Consume`. Il ne faut donc pas définir automatiquement `ψ` comme partielle exactement là où `Consume` est partielle, ni inférer qu’une application de `ψ` autorise à elle seule la traversée d’un effet.

Les règles devront spécifier séparément (1) le domaine et le codomaine de `ψ`, (2) les conditions de typage/autorisation d’une traversée, (3) les cas où la consommation budgétaire est requise, et (4) la correspondance entre le coût annoncé et le budget consommé. D7 ne rend pas `Consume` totale, ne garantit pas l’exécution sûre et ne constitue aucune preuve Lean. Voir la [note D7](../migration/L1-D7-PSI-INDEPENDENT-DOMAIN-2026-10-11.md).


## D-22 — Consommation budgétaire (11 octobre 2026)

Option A ratifiée : conserver la soustraction tronquée prolongée, avec ω ⊖ ω = ω, dans les couches où Consume est utilisée. Les couches déterminent les opérations requises localement, mais ne définissent pas de variantes de ⊖. Les six démonstrations concernées restent à auditer et à prouver. Voir la note D8 dans docs/migration/L1-D8-GLOBAL-TRUNCATED-SUBTRACTION-2026-10-11.md. La porte C demeure NON SATISFAITE.


## D-23 — Loi de compatibilité avec les multiplicités (11 octobre 2026)

**Décision d’autrice : option A.** La loi candidate `n (β ⊖ k) = (n β) ⊖ (n k)` est à formuler sur le domaine admissible où la consommation et les opérations de multiplicité sont définies. La suffisance des hypothèses doit être établie, en particulier pour `n = ω` ; aucune preuve n’est revendiquée.

Une éventuelle factorisation ou loi globale peut être étudiée comme piste de recherche distincte, mais elle n’est pas ratifiée et ne doit pas être considérée comme vraie sans preuve. L’audit des six démonstrations reste requis. Voir [la note D9](../migration/L1-D9-ADMISSIBLE-MULTIPLICITY-LAW-2026-10-11.md). La porte C demeure NON SATISFAITE.


## D-24 — Domaine restreint de la loi de multiplicité (11 octobre 2026)

**Décision d’autrice : option A.** La loi `n (β ⊖ k) = (n β) ⊖ (n k)` est conservée comme lemme conditionnel, avec des hypothèses plus fortes que la seule admissibilité. Les multiplicités autorisées et les hypothèses arithmétiques suffisantes restent à préciser et à prouver ; `n = ω` n’est pas inclus par défaut, compte tenu des contre-exemples sous la convention D8.

Cette loi n’est pas requise par `Scale_Usage` et ne doit pas être une prémisse générale de substitution. L’audit des six démonstrations doit déterminer ses usages effectifs et leur nécessité. Voir [la note D10](../migration/L1-D10-RESTRICT-MULTIPLICITY-LAW-2026-10-11.md). La porte C demeure NON SATISFAITE.


## D-25 — Ordre de travail pour la loi de multiplicité (11 octobre 2026)

**Décision d’autrice : option A.** Auditer d’abord les démonstrations historiquement signalées et leurs dépendances ; ne fixer les hypothèses exactes du lemme arithmétique qu’après cet audit. Les références historiques mélangent numéros de théorèmes, cas LET/APP et correspondances entre numérotations ; leur réconciliation avec les étiquettes Verso actuelles est une étape explicite. La loi de multiplicité ne doit pas devenir une prémisse générale de substitution. Voir [la note D11](../migration/L1-D11-AUDIT-MULTIPLICITY-SITES-2026-10-11.md). La porte C demeure NON SATISFAITE.
