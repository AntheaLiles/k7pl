# Fiches de la campagne PR-02 — état par fiche

Vue **produite** par `scripts/suivi.py fiches` à partir de [`docs/relectures/pr-02/taches-consolidees.md`](../relectures/pr-02/taches-consolidees.md) (le texte des fiches) et de [`fiches-statuts.csv`](fiches-statuts.csv) (l'état, seul fichier à tenir à la main). Ne pas éditer ce fichier.

Confiance : **journal** = le compte rendu de séance nomme la fiche ; **fiche** = l'état est dans la fiche elle-même ; **déduite** = conclue par le rapprochement d'un changement de statut du manuscrit et du texte de la fiche — *à confirmer par l'auteur*.

## Synthèse par lot

| Lot | Fiches | ✅ fermées | 🟡 partielles | ⏳ à ratifier | ❓ décision | ⛔ écartées | ⬜ ouvertes |
|---|--:|--:|--:|--:|--:|--:|--:|
| `BLOQ` Bloquants | 14 | 8 | 6 | 0 | 0 | 0 | 0 |
| `STRUCT` Structurels | 23 | 14 | 3 | 0 | 0 | 0 | 6 |
| `PORT` Portée | 17 | 17 | 0 | 0 | 0 | 0 | 0 |
| `PREUVE` Dettes de preuve | 16 | 2 | 11 | 0 | 0 | 0 | 3 |
| `NOTA` Notation, comptes, renvois | 8 | 8 | 0 | 0 | 0 | 0 | 0 |
| `IMPL` Implémentation et outillage | 9 | 4 | 2 | 0 | 0 | 0 | 3 |
| `FACT` Factorisations à écrire | 24 | 12 | 4 | 0 | 2 | 2 | 4 |
| `REFUS` Factorisations refusées | 7 | 7 | 0 | 0 | 0 | 0 | 0 |
| `REECR` Réécritures d'énoncés | 27 | 26 | 1 | 0 | 0 | 0 | 0 |
| `BIB` Vérifications bibliographiques | 29 | 11 | 6 | 0 | 0 | 0 | 12 |
| `TRANS` Refontes transversales | 9 | 2 | 0 | 0 | 0 | 0 | 7 |
| `ARB-PR` Arbitrages | 7 | 5 | 0 | 1 | 1 | 0 | 0 |
| **Total** | **190** | **116** | **33** | **1** | **3** | **2** | **35** |

## BLOQ — Bloquants

| Fiche | État | Titre | Preuve · note |
|---|---|---|---|
| `BLOQ-01` | ✅ fermée | Le noyau formel est séquentiel ; la couche 2 n'a ni règles, ni constructeurs, ni types habitables | [journal](../historique/2026-10-01-pr-02-avancement.md) |
| `BLOQ-02` | ✅ fermée | La modalité duale de ◇ n'a ni nom, ni glyphe, ni clause grammaticale ; la règle WHEN imprimée est celle que le texte déclare fausse | [journal](../historique/2026-10-01-pr-02-avancement.md) |
| `BLOQ-03` | ✅ fermée | Le Th. 1 (loi de cohérence) est faux au grade ω ; deux conventions de `⊖` coexistent | [journal](../journal/2026-09-30-pr-02-01-bloq-03-et-06.md) · ⊖ défini par cas ; loi d'action restreinte ; contrôle écrit avant la correction |
| `BLOQ-04` | ✅ fermée | ℛ désigne deux structures incompatibles ; l'action scalaire n'est pas définie sur deux de ses quatre facteurs | [journal](../historique/2026-10-01-pr-02-avancement.md) |
| `BLOQ-05` | 🟡 partielle | Le niveau d'un calcul est invoqué par cinq démonstrations et produit par aucune règle ; le symbole ℓ recouvre deux ordres | [journal](../journal/2026-10-01-pr-02-11-bloq-sur-le-verso.md) · clauses Op/Case et Tick posées ; lemme de correspondance et relecture des Th. 43-51 à faire |
| `BLOQ-06` | ✅ fermée | La clause de taille `i ∈ ℕ∞ ∖ {ω}` interdit les acteurs et flux non bornés que le document exige | [journal](../journal/2026-09-30-pr-02-01-bloq-03-et-06.md) · deux sortes de tailles 𝕊_μ / 𝕊_ν |
| `BLOQ-07` | 🟡 partielle | Deux sémantiques opérationnelles concurrentes, sans théorème d'accord | [journal](../journal/2026-10-01-pr-02-11-bloq-sur-le-verso.md) · énoncé rendu conditionnel à Sim ; Sim à établir (PREUVE-07) |
| `BLOQ-08` | 🟡 partielle | La catégorie ambiante 𝒞 n'interprète rien : P1 est un axiome sans modèle | [journal](../journal/2026-10-01-pr-02-11-bloq-sur-le-verso.md) · P1b nommée ; Th. 31 et §4.6 à reprendre |
| `BLOQ-09` | 🟡 partielle | Le Th. 21 invoque l'absence de diagonale, alors que la propriété requise est l'unicité d'introduction de la capacité | [journal](../journal/2026-10-01-pr-02-11-bloq-sur-le-verso.md) · H1 et H2 posées en hypothèses ; lemmes à démontrer (PREUVE-12) |
| `BLOQ-10` | ✅ fermée | Le Th. 35 invoque l'inférence principale, que le document réfute deux fois | [journal](../journal/2026-10-01-pr-02-11-bloq-sur-le-verso.md) · D_det nommée ; ses trois composantes restent à écrire (PREUVE-15) |
| `BLOQ-11` | ✅ fermée | La règle (10) de déclassification n'a pas reçu la clause de clôture de 𝒳 ; elle admet le blanchiment par substitution | [journal](../journal/2026-10-01-pr-02-11-bloq-sur-le-verso.md) |
| `BLOQ-12` | 🟡 partielle | Le Th. 18 n'établit aucun homomorphisme et sa conclusion sur les lois de la théorie des roues est fausse | [journal](../journal/2026-10-01-pr-02-11-bloq-sur-le-verso.md) · table de propagation à écrire (IMPL-07) |
| `BLOQ-13` | ✅ fermée | Le graphe de câblage, hypothèse du Th. 17 et du Th. 24, n'est défini nulle part | [journal](../historique/2026-10-01-pr-02-avancement.md) |
| `BLOQ-14` | 🟡 partielle | Le ch. 1 et le ch. 2 énoncent le sous-typage modal dans le sens inverse de la règle SUBBOX et de la table 20 | [journal](../journal/2026-10-01-pr-02-11-bloq-sur-le-verso.md) · table 20 non remontée (TRANS-06) |

## STRUCT — Structurels

| Fiche | État | Titre | Preuve · note |
|---|---|---|---|
| `STRUCT-01` | ⬜ ouverte | Inversion d'antériorité : le jugement germinal n'est pas germinal |  |
| `STRUCT-02` | ✅ fermée | Le monoïde ℳ est une pièce théorique nouvelle ; la condition de clôture est trop fortement énoncée | [journal](../journal/2026-10-01-pr-02-06-theoremes.md) · ℰ_alg / ℰ_scoped, clôture faible (position intermédiaire de ARB-PR-03) |
| `STRUCT-03` | ✅ fermée | Un seul environnement normatif pour sept natures épistémiques ; quatre statuts incompatibles pour le Th. 27 | [journal](../historique/2026-10-01-pr-02-avancement.md) |
| `STRUCT-04` | ✅ fermée | La couche 2 est asynchrone au ch. 3, synchrone dans le noyau, SPSC au ch. 4 | [journal](../historique/2026-10-01-pr-02-avancement.md) |
| `STRUCT-05` | ⬜ ouverte | La trace τ est à la fois grandeur de coût à optimiser et observable de sûreté à préserver ; aucun invariant de passe n'est déclaré |  |
| `STRUCT-06` | 🟡 partielle | Le pipeline n'a pas de Phase 0 ; « élaboration » désigne deux opérations différentes | [journal](../journal/2026-10-05-pr-02-19-preuves-detaillees.md) · phase 2.5 renommée Résolution (figure 11 régénérée) ; Phase 0 Expansion à ajouter à la figure |
| `STRUCT-07` | 🟡 partielle | Le Th. 39 ne prouve pas la cohérence du sous-typage : l'existence de joints n'est pas la cohérence des coercions | [journal](../journal/2026-10-01-pr-02-08-fact-suite.md) · énoncé scellé proposition ; la preuve par facteur reste à conduire (PREUVE-10) |
| `STRUCT-08` | ✅ fermée | Le système de raffinement (Th. 9) est conditionnel à une traduction encore ouverte (Th. 27) | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · Th. raffinement conditionnel à la traduction |
| `STRUCT-09` | ✅ fermée | « Tout le non-déterminisme est journalisé » est une obligation sémantique, pas une conséquence de la pureté | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · journal complet posé en paramètre de l'hypothèse de rejeu |
| `STRUCT-10` | ✅ fermée | L'histomorphisme réclame une loi distributive qui n'était pas dans le noyau | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · λ classée structure dérivée de l'instance historique |
| `STRUCT-11` | ✅ fermée | Les effets à portée ne sont pas absorbés par ℰ ; ℰ_alg et ℰ_scoped doivent être distingués dans la structure | [journal](../journal/2026-10-01-pr-02-06-theoremes.md) · idem |
| `STRUCT-12` | ✅ fermée | Hygiène syntaxique et hygiène quantitative : le Th. 31 ne doit pas hériter automatiquement du Th. 30 | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · Th. hygiène non gradué et gradué scindés (PORT-14) |
| `STRUCT-13` | ✅ fermée | La discipline d'échange est « voie retenue » au ch. 3, « envisagée » au ch. 4 et à l'annexe, « absente » dans les règles | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · « voie disponible, dont le prix est chiffré » (ch. 3) |
| `STRUCT-14` | ✅ fermée | `𝒢_pile` et `𝒢_budget`, sous-algèbres qui *définissent* les couches, ne sont jamais construites | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · G_pile et G_budget définis par projection ; clause de portée de P3 |
| `STRUCT-15` | ⬜ ouverte | « Gestionnaire » désigne deux objets de niveaux différents ; l'hypothèse de pureté du Th. 22 renvoie à des sections qui ne la contiennent pas |  |
| `STRUCT-16` | 🟡 partielle | Quatre régimes de grade théoriques, trois exposés : la clôture n'est pas établie | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · modes atteignables énoncés ; preuve par examen des règles à conduire |
| `STRUCT-17` | ✅ fermée | Quatre concepts de monotonie portent un seul nom | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · trois notions de monotone distinguées (§2.4) |
| `STRUCT-18` | ✅ fermée | Surcharge de `⊗` : tenseur catégorique, composition de contextes, opération syntaxique du jugement | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · table normative : Δ₁+Δ₂, ⊠, ⊗ des types, ⊗_𝒞, ℓ et ℓ̂ |
| `STRUCT-19` | ⬜ ouverte | La distinction compilation / exécution est une phase, pas encore une modalité |  |
| `STRUCT-20` | ⬜ ouverte | La loi distributive graduée : signature sous-déterminée et règles non écrites |  |
| `STRUCT-21` | ⬜ ouverte | Tension non résolue entre appel par poussée de valeur, types dépendants et effets indexés |  |
| `STRUCT-22` | ✅ fermée | L'orthogonalité annoncée par P2 est rompue en trois points | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · P2 qualifiée : orthogonalité au niveau du jugement, trois couplages nommés |
| `STRUCT-23` | ✅ fermée | L'annexe E est une fondation tardive ; le jeu de règles doit remonter dans le corps | [journal](../journal/2026-10-01-pr-02-15-fusion-annexe-e.md) · annexe E fondue : règles au ch. 3, sémantique au ch. 4 ; §1.1 corrigé |

## PORT — Portée

| Fiche | État | Titre | Preuve · note |
|---|---|---|---|
| `PORT-01` | ✅ fermée | Zéro-copie : trois affirmations de portées inégales présentées comme une seule ; Th. 20 sans paramètre de version | [journal](../journal/2026-10-01-pr-02-16-nota-et-ratifications.md) · domaine et profil Π écrits ; rappel au §6.1 ; endianness et alignement |
| `PORT-02` | ✅ fermée | « L'isolation repose entièrement sur les types » : la réserve est écrite, l'affirmation n'est pas corrigée | [journal](../journal/2026-10-01-pr-02-09-port-et-fact2.md) |
| `PORT-03` | ✅ fermée | « À l'exécution, l'audit trouve trois régions et non six » : un décompte sans méthode | [journal](../journal/2026-10-01-pr-02-09-port-et-fact2.md) |
| `PORT-04` | ✅ fermée | Le rejeu bit-à-bit : hypothèse insuffisante, et un autre théorème l'élargit sans le dire | [journal](../historique/2026-10-01-pr-02-avancement.md) |
| `PORT-05` | ✅ fermée | Le Th. 26 énonce comme conclusion ce que la remarque suivante retire et ce que le paragraphe précédent déclare manquant | [journal](../journal/2026-10-01-pr-02-09-port-et-fact2.md) · thm:surete_ffi scindé : clause 1 théorème, clause 2 exigence ⟨représentation⟩ |
| `PORT-06` | ✅ fermée | Le Th. 34 ré-affirme comme théorème la direction que le ch. 1 a explicitement retirée | [journal](../journal/2026-10-01-pr-02-16-nota-et-ratifications.md) · Th. 34 : définition + clôture locale, suffisante non nécessaire |
| `PORT-07` | ✅ fermée | Le Th. 16 (complétude graduée) est une propriété du vérificateur prouvée par énumération sur un catalogue déclaré non exhaustif | [journal](../journal/2026-10-01-pr-02-16-nota-et-ratifications.md) · complétude restreinte au noyau ; exigence thm:completude_verificateur ; comptes retirés |
| `PORT-08` | ✅ fermée | Le Th. 31 quantifie sur une fonction `Sens` jamais définie ; le Th. 29 est un faux corollaire | [deduite](../journal/2026-10-01-pr-02-09-port-et-fact2.md) · thm:elaboration requalifié définition — à confirmer |
| `PORT-09` | ✅ fermée | Amortissement et pire cas : P3 doit dire lequel il gouverne | [journal](../historique/2026-10-01-pr-02-avancement.md) |
| `PORT-10` | ✅ fermée | Le budget est une borne supérieure dont l'écart au coût réel n'est pas borné | [journal](../journal/2026-10-01-pr-02-09-port-et-fact2.md) |
| `PORT-11` | ✅ fermée | « Deux paquets sémantiquement équivalents partagent un hash » est faux dans la construction actuelle | [journal](../journal/2026-10-01-pr-02-09-port-et-fact2.md) |
| `PORT-12` | ✅ fermée | R-expressions : trois écarts entre la classe de machine et la borne annoncée | [journal](../journal/2026-10-01-pr-02-16-nota-et-ratifications.md) · §4.2 : O(n), @stack/@backtrack, pile bornée ; figure 7 corrigée |
| `PORT-13` | ✅ fermée | La condition de clôture doit être énoncée comme suffisante, non nécessaire | [journal](../journal/2026-10-01-pr-02-16-nota-et-ratifications.md) · propagée aux ch. 5 et 6 |
| `PORT-14` | ✅ fermée | Trois réserves déjà identifiées mais laissées hors des énoncés | [journal](../journal/2026-10-01-pr-02-16-nota-et-ratifications.md) · hygiène graduée et resucrage ; Th. 19 scindé ; sédimentation en deux temps |
| `PORT-15` | ✅ fermée | La sédimentation s'inverse sur deux axes, pas un ; la réserve du §1.2 doit être mise à jour | [journal](../journal/2026-10-01-pr-02-09-port-et-fact2.md) |
| `PORT-16` | ✅ fermée | Le Th. 36 est affirmé comme acquis au ch. 3 et déclaré non démontré au ch. 6 | [deduite](../journal/2026-10-01-pr-02-09-port-et-fact2.md) · thm:abaissement_grades requalifié conjecture ⟨compilation⟩ — à confirmer |
| `PORT-17` | ✅ fermée | Le manuscrit revendique à la fois un modèle invariant par équivalence et une détermination de la représentation, sans dire que les deux tirent en sens opposé | [journal](../journal/2026-10-01-pr-02-09-port-et-fact2.md) |

## PREUVE — Dettes de preuve

| Fiche | État | Titre | Preuve · note |
|---|---|---|---|
| `PREUVE-01` | 🟡 partielle | Th. 45 (correction de ressource) : la dette la plus lourde, et deux postulats en dépendent | [journal](../journal/2026-10-01-pr-02-06-theoremes.md) · énoncé repris sous concurrence ; la démonstration reste la dette la plus lourde |
| `PREUVE-02` | ⬜ ouverte | Th. 36 : préservation graduée par abaissement |  |
| `PREUVE-03` | 🟡 partielle | Non-interférence graduée sur le fragment avec communication | [journal](../journal/2026-10-01-pr-02-07-non-interference-et-fact.md) · non-interférence séquentielle située ; déterminisme observationnel scellé conjecture sous hypothèse nommée |
| `PREUVE-04` | 🟡 partielle | Th. 7 (divulgation délimitée) : l'esquisse est circulaire | [journal](../journal/2026-10-01-pr-02-14-preuves.md) · Th. 9 requalifié proposition, route nommée (paramétricité), renvoi corrigé ; preuve à conduire |
| `PREUVE-05` | ⬜ ouverte | Écrire les règles de la loi distributive graduée et vérifier leur cohérence |  |
| `PREUVE-06` | ⬜ ouverte | Gradation indexée et substitution d'indices |  |
| `PREUVE-07` | 🟡 partielle | Lemme de simulation entre `→` et `⟦·⟧` | [journal](../journal/2026-10-05-pr-02-19-preuves-detaillees.md) · cas pures, congruence et trace détaillés ; exigence : traduction qui enfile le canal de temps ; clauses d'opération à écrire |
| `PREUVE-08` | 🟡 partielle | Th. 6 : la troncature préserve-t-elle les lois de comonade ? | [journal](../journal/2026-10-05-pr-02-19-preuves-detaillees.md) · convention de remplissage et récurrence écrites ; vérification pour chaque F à faire |
| `PREUVE-09` | 🟡 partielle | Th. 40 : deux structures pour ℰ₀, et une pétition de principe au second temps | [journal](../journal/2026-10-01-pr-02-14-preuves.md) · énoncé en deux temps ; hypothèse (ii) nommée exigence sur ℰ₀ |
| `PREUVE-10` | 🟡 partielle | Cohérence des coercions par facteur, puis fermeture par produit | [journal](../journal/2026-10-05-pr-02-19-preuves-detaillees.md) · conversions définies par facteur ; équation w∘ε=w à vérifier au ch. 2 |
| `PREUVE-11` | 🟡 partielle | Relation logique sur un produit de structures ordonnées | [journal](../journal/2026-10-05-pr-02-19-preuves-detaillees.md) · clause par facteur écrite ; facteur budget à écrire |
| `PREUVE-12` | 🟡 partielle | Unicité d'introduction de `WriteCap` et lemme de portée | [journal](../journal/2026-10-01-pr-02-14-preuves.md) · lemme de portée démontré (arithmétique d'intervalles) ; unicité H1 attend la règle d'introduction |
| `PREUVE-13` | ✅ fermée | Lemme de simulation du graphe d'attente, et hypothèse d'équité | [journal](../journal/2026-10-01-pr-02-06-theoremes.md) · l'absence d'interblocage n'emprunte plus : le graphe de câblage est lu des règles |
| `PREUVE-14` | ✅ fermée | Th. 5 : schéma de méta-théorème à deux instanciations, et non identité des conclusions | [journal](../journal/2026-10-01-pr-02-14-preuves.md) · schéma de méta-théorème, deux instanciations aux conclusions distinctes |
| `PREUVE-15` | 🟡 partielle | Hypothèse `D_det` : déterminisme des parcours, recherches et graines | [journal](../journal/2026-10-01-pr-02-14-preuves.md) · D_det écrite (parcours, recherche, graine) en E.4.1 ; implémentation à spécifier dans l'outillage |
| `PREUVE-16` | 🟡 partielle | Th. 3 : transposition graduée de la préservation des conteneurs | [journal](../journal/2026-10-01-pr-02-14-preuves.md) · énoncé en deux temps, contrainte d'outil nommée ; cas gradué ouvert |

## NOTA — Notation, comptes, renvois

| Fiche | État | Titre | Preuve · note |
|---|---|---|---|
| `NOTA-01` | ✅ fermée | La table 5 est déclarée normative et le document la contredit : 12 collisions, 11 symboles hors table | [journal](../historique/2026-10-01-pr-02-avancement.md) |
| `NOTA-02` | ✅ fermée | `tick` : instance ou constructeur ? | [journal](../journal/2026-10-01-pr-02-16-nota-et-ratifications.md) · Tick déclarée admissible (instance d'Op) |
| `NOTA-03` | ✅ fermée | Les comptes ne se recoupent pas : 39 / 35 / 34, et 19 / 18 / 49 / 21 | [journal](../historique/2026-10-01-pr-02-avancement.md) |
| `NOTA-04` | ✅ fermée | Table 8 : la couche 3 a « Δ = ∅ », alors que le reste du document dit `Δ_ω` | [journal](../journal/2026-10-01-pr-02-16-nota-et-ratifications.md) · Δ = Δ_ω au §5.1 et §5.5 |
| `NOTA-05` | ✅ fermée | `ε_m` désigne deux effets dans le Th. 32, et `∏_i` est non commutatif sur un ensemble d'indices non ordonné | [journal](../journal/2026-10-01-pr-02-16-nota-et-ratifications.md) · ε_exp, ε_body, occ(m) ; table 11 corrigée |
| `NOTA-06` | ✅ fermée | Six défauts formels localisés, mécaniquement bloquants, vérifiables en une ligne | [journal](../journal/2026-10-01-pr-02-16-nota-et-ratifications.md) · a, c, d, f corrigés ; b par renvoi ; e par BLOQ-02 |
| `NOTA-07` | ✅ fermée | Identifiants de travail non résolus | [journal](../journal/2026-10-01-pr-02-16-nota-et-ratifications.md) · identifiants T-xx et G.x résolus en renvois de section |
| `NOTA-08` | ✅ fermée | Corriger les renvois faux de pureté des gestionnaires | [journal](../journal/2026-09-30-pr-02-03-vague-0-fin.md) · deux renvois faux, définition de la pureté des gestionnaires |

## IMPL — Implémentation et outillage

| Fiche | État | Titre | Preuve · note |
|---|---|---|---|
| `IMPL-01` | ✅ fermée | Le solveur est traité comme une boîte noire, ce qui contredit le code porteur de preuve de l'annexe D | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · certificat exigé aux frontières de paquet (§6.1 Phase 5, annexe D) |
| `IMPL-02` | ✅ fermée | Compilation reproductible : visée et non garantie | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · critère opérationnel écrit en fin de §6.3 |
| `IMPL-03` | ✅ fermée | Protocole de réglage du test différentiel | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · protocole du test différentiel écrit en fin de §6.3 |
| `IMPL-04` | ⬜ ouverte | Structure réelle des boîtes aux lettres et protocole d'appariement atomique |  |
| `IMPL-05` | ✅ fermée | Révocation d'une capacité exportée à la frontière FFI | [journal](../journal/2026-10-01-pr-02-09-port-et-fact2.md) · thm:revocation_ffi : première exigence du document |
| `IMPL-06` | 🟡 partielle | Profil de représentation `Π` unique | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · Π défini au §4.5 ; Th. 20 et rejeu requalifiés en conformité ; Th. 36 non requalifié |
| `IMPL-07` | ⬜ ouverte | Table de propagation des singularités |  |
| `IMPL-08` | 🟡 partielle | Renforcer le croisement mécanique grammaire × règles | [journal](../journal/2026-10-01-pr-02-17-impl-et-struct.md) · productions dégénérées et types non engendrés contrôlés (mutation vérifiée) ; arités et build sur symbole absent restent à porter |
| `IMPL-09` | ⬜ ouverte | Hypothèses de module à porter en assistant de preuve |  |

## FACT — Factorisations à écrire

| Fiche | État | Titre | Preuve · note |
|---|---|---|---|
| `FACT-01` | ✅ fermée | Schéma de commutation graduée (transport-échelle) | [journal](../journal/2026-10-01-pr-02-07-non-interference-et-fact.md) |
| `FACT-02` | ✅ fermée | Schéma de restriction `ρ_p` (projection par niveau) | [journal](../journal/2026-10-01-pr-02-07-non-interference-et-fact.md) |
| `FACT-03` | ✅ fermée | Schéma de bien-fondation (progression polarisée) | [journal](../journal/2026-10-01-pr-02-07-non-interference-et-fact.md) |
| `FACT-04` | ✅ fermée | Schéma de ré-invocation bornée | [journal](../journal/2026-10-01-pr-02-08-fact-suite.md) |
| `FACT-05` | 🟡 partielle | Théorème de cohérence des coercions | [journal](../journal/2026-10-01-pr-02-08-fact-suite.md) · le théorème recule en proposition ; voie écrite, preuve à conduire |
| `FACT-06` | ✅ fermée | Théorème d'effacement / simulation | [journal](../journal/2026-10-01-pr-02-08-fact-suite.md) |
| `FACT-07` | ⬜ ouverte | Théorème fondamental de préservation fibrée | [journal](../journal/2026-10-01-pr-02-13-fact-fin.md) · attend PREUVE-11 (BLOQ-05 est levé) |
| `FACT-08` | ⬜ ouverte | Le partage en lecture et le partage de canal sont un seul geste | [journal](../journal/2026-10-01-pr-02-10-fact-second-rang.md) · redevenue disponible : le périmètre du noyau est stabilisé |
| `FACT-09` | 🟡 partielle | L'inexpressibilité comme unique mode de garantie, et la réduction des familles d'erreurs | [journal](../journal/2026-10-01-pr-02-13-fact-fin.md) · principe énoncé au §1.4 ; table code ⟷ prémisse à écrire (PORT-07) |
| `FACT-10` | ⬜ ouverte | Séquencement dans la quantale et préfixage dans le calcul de processus | [journal](../journal/2026-10-01-pr-02-13-fact-fin.md) · attend PREUVE-07 (lemme de simulation) |
| `FACT-11` | 🟡 partielle | `Mailbox` comme objet unique | [journal](../journal/2026-10-01-pr-02-13-fact-fin.md) · objet Mailbox posé au §4.5 ; reprise des quatre énoncés à faire |
| `FACT-12` | ❓ décision | Adjonction graduée unifiant coeffets et effets | [journal](../journal/2026-10-01-pr-02-13-fact-fin.md) · choix de formulation : ARB-PR-05 écarte déjà FACT-21/22 ; à réévaluer avec STRUCT-01 |
| `FACT-13` | ✅ fermée | Une seule loi de substitution pour quatre lemmes | [journal](../journal/2026-10-01-pr-02-10-fact-second-rang.md) |
| `FACT-14` | ❓ décision | Cadre unique des structures monotones | [journal](../journal/2026-10-01-pr-02-13-fact-fin.md) · dépend de STRUCT-17 (quatre notions de monotonie) |
| `FACT-15` | ✅ fermée | Une seule relation d'équivalence observationnelle pour les trois rejeux | [journal](../journal/2026-10-01-pr-02-10-fact-second-rang.md) |
| `FACT-16` | ✅ fermée | `Injectivité(obs, repr)` comme exigence de représentation unique | [journal](../journal/2026-10-01-pr-02-12-fact-17-et-16.md) · exigence thm:representation_inobservable ; vérifiée par test différentiel |
| `FACT-17` | ✅ fermée | Une loi unique d'introduction des ressources d'écriture | [journal](../journal/2026-10-01-pr-02-12-fact-17-et-16.md) · énoncé unique écrit (thm:introduction_unique) ; preuve à écrire (PREUVE-12) |
| `FACT-18` | 🟡 partielle | La fenêtre statiquement dimensionnée sur un objet coinductif | [journal](../journal/2026-10-01-pr-02-13-fact-fin.md) · principe posé au §2.6 ; lemme de troncature à écrire à part |
| `FACT-19` | ✅ fermée | L'ordre d'occurrence | [journal](../journal/2026-10-01-pr-02-10-fact-second-rang.md) |
| `FACT-20` | ⬜ ouverte | Annexe unique « classes de motifs et bornes » |  |
| `FACT-21` | ⛔ écartée | Architecture minimale à cinq couches de preuve | [journal](../journal/2026-10-01-pr-02-10-fact-second-rang.md) · cadres de rédaction écartés par ARB-PR-05 ; à consigner dans factorisations-refusees.md |
| `FACT-22` | ⛔ écartée | Formulation fibrée bimodale | [journal](../journal/2026-10-01-pr-02-10-fact-second-rang.md) · cadres de rédaction écartés par ARB-PR-05 ; à consigner dans factorisations-refusees.md |
| `FACT-23` | ✅ fermée | Relation entre `□` et la modalité duale de ◇ | [journal](../journal/2026-10-01-pr-02-09-port-et-fact2.md) · le connecteur ■ n'était pas nécessaire : □ suffit, ■ retiré |
| `FACT-24` | ✅ fermée | Le système de modes comme unique lieu des onze modalités | [journal](../journal/2026-10-01-pr-02-10-fact-second-rang.md) |

## REFUS — Factorisations refusées

| Fiche | État | Titre | Preuve · note |
|---|---|---|---|
| `REFUS-01` | ✅ fermée | grade et indice de taille | [journal](../journal/2026-10-01-pr-02-07-non-interference-et-fact.md) · documenté dans suivi/factorisations-refusees.md |
| `REFUS-02` | ✅ fermée | la comonade d'usage `!^r` et la comonade cofree de l'histomorphisme | [journal](../journal/2026-10-01-pr-02-07-non-interference-et-fact.md) · documenté dans suivi/factorisations-refusees.md |
| `REFUS-03` | ✅ fermée | graphe de câblage et graphe d'attente | [journal](../journal/2026-10-01-pr-02-07-non-interference-et-fact.md) · documenté dans suivi/factorisations-refusees.md |
| `REFUS-04` | ✅ fermée | `π†` et `π_ℓ` | [journal](../journal/2026-10-01-pr-02-07-non-interference-et-fact.md) · documenté dans suivi/factorisations-refusees.md |
| `REFUS-05` | ✅ fermée | tailles inductives et coinductives | [journal](../journal/2026-10-01-pr-02-07-non-interference-et-fact.md) · documenté dans suivi/factorisations-refusees.md |
| `REFUS-06` | ✅ fermée | Th. 19, Th. 36 et Th. 43 | [journal](../journal/2026-10-01-pr-02-07-non-interference-et-fact.md) · documenté dans suivi/factorisations-refusees.md |
| `REFUS-07` | ✅ fermée | effets algébriques et effets à portée | [journal](../journal/2026-10-01-pr-02-07-non-interference-et-fact.md) · documenté dans suivi/factorisations-refusees.md |

## REECR — Réécritures d'énoncés

| Fiche | État | Titre | Preuve · note |
|---|---|---|---|
| `REECR-01` | ✅ fermée | « tout programme K7PL est un morphisme dans une catégorie ambiante 𝒞 » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · P1a / P1b (BLOQ-08) |
| `REECR-02` | ✅ fermée | « l'isolation entre eux repose **entièrement** sur les preuves du système de types » | [deduite](../journal/2026-10-01-pr-02-09-port-et-fact2.md) · obtenue avec PORT-02 — à confirmer |
| `REECR-03` | ✅ fermée | « fidèle à la sémantique de K7PL sur la structure de communication, sur le contrôle et sur les effets » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · Th. fidélité conditionnel à Sim (BLOQ-07) |
| `REECR-04` | ✅ fermée | « les correspondances rendent cette génération de code directe » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · domaine du Th. 20 rappelé au §6.1 |
| `REECR-05` | ✅ fermée | « Trois réponses, trois domiciles, et aucune quatrième place à inventer » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · clôture forte (données) / faible (actions) |
| `REECR-06` | ✅ fermée | « À l'exécution, l'audit trouve trois régions et non six » | [deduite](../journal/2026-10-01-pr-02-09-port-et-fact2.md) · obtenue avec PORT-03 — à confirmer |
| `REECR-07` | ✅ fermée | le budget lu comme prédiction | [deduite](../journal/2026-10-01-pr-02-09-port-et-fact2.md) · obtenue avec PORT-10 — à confirmer |
| `REECR-08` | ✅ fermée | « Le théorème 27 est donc démontré, et la dette de fidélité est acquittée » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · traduction : induction planifiée, non conduite ; statut proposition |
| `REECR-09` | ✅ fermée | « La non-interférence graduée et la divulgation délimitée cessent d'être bornées au fragment sans communication » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · NI et divulgation restent bornées au fragment sans communication |
| `REECR-10` | ✅ fermée | « Aucune obligation ne déborde de ces trois » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · Th. 34 : définition + clôture locale |
| `REECR-11` | ✅ fermée | « le système hôte ne peut y accéder après le retour » | [deduite](../journal/2026-10-01-pr-02-09-port-et-fact2.md) · obtenue avec PORT-05 — à confirmer |
| `REECR-12` | ✅ fermée | « l'égalité observationnelle se transporte en identité de représentation » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · E_repro élargie à l'architecture ; injectivité |
| `REECR-13` | ✅ fermée | « préservant les lois algébriques de la théorie des roues, par exemple ⊥ + y = ⊥ » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · retiré (Th. 18 réécrit) |
| `REECR-14` | ✅ fermée | « l'audit des dix-huit familles d'erreurs » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · énumération sur le noyau |
| `REECR-15` | ✅ fermée | « les trois dispositions coïncident bit à bit » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · profil Π |
| `REECR-16` | 🟡 partielle | « la syntaxe d'un programme est fixée à l'issue de la Phase 0 » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · Th. 29 à conserver une fois la Phase 0 portée par la figure 11 |
| `REECR-17` | ✅ fermée | « la dérivation est déterministe puisque l'inférence est principale » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · hypothèse D_det |
| `REECR-18` | ✅ fermée | « un ordre que rien ne permet d'inverser » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · ordre : exception de la Phase 5 reconnue |
| `REECR-19` | ✅ fermée | « la couche 2 est un π-calcul enrichi de motifs de jonction » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · traduction de la couche 2 séquentielle seulement |
| `REECR-20` | ✅ fermée | `𝒞_{!S}` avec S singleton (ch. 2) contre intervalles (ch. 3) | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · singletons = fragments logiques, intervalles = modalités |
| `REECR-21` | ✅ fermée | « la transposition à la gradation reste à faire » (RMQ 14) | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · réserve portée au ch. 1 |
| `REECR-22` | ✅ fermée | « Le jeu de règles de typage lui-même, dont l'absence est ce qui suspend les quatre preuves ouvertes » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · jeu de règles existant ; §1.1 corrigé |
| `REECR-23` | ✅ fermée | « sans en payer le prix » (sûreté des gestionnaires d'effets en PBV) | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · prix des suspensions mentionné |
| `REECR-24` | ✅ fermée | « l'isolation par types remplace la MMU **par construction** » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · terminalité : logique, non physique |
| `REECR-25` | ✅ fermée | « deux paquets sémantiquement équivalents partagent un seul hash » | [deduite](../journal/2026-10-01-pr-02-09-port-et-fact2.md) · obtenue avec PORT-11 — à confirmer |
| `REECR-26` | ✅ fermée | `@linear` — DFA `O(1)` (figure 7) | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · O(n), O(1) par bloc |
| `REECR-27` | ✅ fermée | « Le jugement de couche 3 ne comporte pas de Δ » | [journal](../journal/2026-10-01-pr-02-18-reecr.md) · Δ = Δ_ω |

## BIB — Vérifications bibliographiques

| Fiche | État | Titre | Preuve · note |
|---|---|---|---|
| `BIB-01` | ⬜ ouverte | *Hefty Algebras* (Van der Rest & Bach Poulsen, 2023/2025) |  |
| `BIB-02` | ⬜ ouverte | Saffrich & Thiemann 2025 — priorités sur boîtes aux lettres | [journal](../bibliographie/verifications-pr02.md) · référence introuvable en ligne : à vérifier auprès du relecteur |
| `BIB-03` | ✅ fermée | QTAL / défonctionnalisation quantitative (Huang 2023) | [journal](../bibliographie/verifications-pr02.md) · statut exact : quantitatif en cours, dépendant publié |
| `BIB-04` | 🟡 partielle | Join-calculus de Fournet–Gonthier [60] — file de jonction | [journal](../bibliographie/verifications-pr02.md) · join-calculus confirmé ; protocole = IMPL-04 |
| `BIB-05` | ⬜ ouverte | Cohérence des sémantiques de coercions |  |
| `BIB-06` | ✅ fermée | Sabelfeld & Myers — divulgation délimitée | [journal](../bibliographie/verifications-pr02.md) · échappatoires = expressions confirmé ; clôture = notre précision |
| `BIB-07` | ✅ fermée | Issue Agda sur les tailles réflexives [25] | [journal](../bibliographie/verifications-pr02.md) · source incrimine la plus grande taille ∞<∞ ; scission 𝕊_μ/𝕊_ν tient |
| `BIB-08` | ✅ fermée | IEEE 754 — propagation de charge utile des NaN | [journal](../bibliographie/verifications-pr02.md) · charge utile NaN recommandée, non exigée ; architecture dans E_repro |
| `BIB-09` | 🟡 partielle | Spécifications Arrow et Cap'n Proto | [journal](../bibliographie/verifications-pr02.md) · Arrow vérifié ; endianness et Cap'n Proto à vérifier |
| `BIB-10` | ✅ fermée | Licata–Shulman–Riley — systèmes de modes | [journal](../bibliographie/verifications-pr02.md) · confirmé (résumé) |
| `BIB-11` | ⬜ ouverte | Régions par polymorphisme paramétrique [19] |  |
| `BIB-12` | ⬜ ouverte | Extension additive de la logique linéaire classique, transport intuitionniste |  |
| `BIB-13` | ⬜ ouverte | Resucrage et algèbre de liaison de surface [26] |  |
| `BIB-14` | ⬜ ouverte | Types de chemin cubiques et assistant visé |  |
| `BIB-15` | ⬜ ouverte | LMAX Disruptor contre preuve mécanisée de file bornée |  |
| `BIB-16` | ⬜ ouverte | Monoïde ordonné par treillis [27] contre quantale |  |
| `BIB-17` | ⬜ ouverte | Invalidation explicite des protocoles d'accès distant [54] |  |
| `BIB-18` | ✅ fermée | Ergonomie : essai contrôlé randomisé défavorable + étude sur les barrières d'adoption | [journal](../bibliographie/verifications-pr02.md) · rien à corriger |
| `BIB-19` | ⬜ ouverte | Castellan et al. — triangle effets / élimination dépendante / substitution |  |
| `BIB-20` | ✅ fermée | calf / decalf — cadre logique conscient du coût | [journal](../bibliographie/verifications-pr02.md) · calf/decalf confirmés |
| `BIB-21` | 🟡 partielle | Théorie des types graduée formalisée (Abel–Danielsson–Eriksson) | [journal](../bibliographie/verifications-pr02.md) · confirmé ; restriction sur l'égalité définitionnelle à lire dans le corps |
| `BIB-22` | ✅ fermée | Récursion gardée multi-horloges (CloTT) ; bisimulation comme type de chemin | [journal](../bibliographie/verifications-pr02.md) · CloTT confirmé |
| `BIB-23` | ✅ fermée | Granule — sessions et types modaux gradués ; TLL_C — sessions dépendantes | [journal](../bibliographie/verifications-pr02.md) · Granule/TLL_C confirmés |
| `BIB-24` | 🟡 partielle | Théorie cubique sans types Glue (XTT et variantes) | [journal](../bibliographie/verifications-pr02.md) · XTT : extensionnalité sans univalence ; compatibilité avec la sédimentation à instruire |
| `BIB-25` | 🟡 partielle | Algèbre de Kleene concurrente (Hoare, Möller, Struth, Wehrman) | [journal](../bibliographie/verifications-pr02.md) · loi d'échange confirmée ; compatibilité avec la résiduation à vérifier |
| `BIB-26` | ⬜ ouverte | Déterminisme observationnel et flux d'information concurrent |  |
| `BIB-27` | 🟡 partielle | Types de boîtes aux lettres (de'Liguoro–Padovani, ECOOP 2018) ; *Special Delivery* (Fowler et al.) | [journal](../bibliographie/verifications-pr02.md) · confirmé ; théorème d'interblocage à lire |
| `BIB-28` | ✅ fermée | Exceptional GV / types de session asynchrones exceptionnels (Fowler–Lindley–Morris–Decova, POPL 2019) | [journal](../bibliographie/verifications-pr02.md) · confirmé |
| `BIB-29` | ✅ fermée | Valeurs localisées (HasChor, ChorLean, valeurs multiplement localisées) | [journal](../bibliographie/verifications-pr02.md) · ChorLean en Lean confirmé |

## TRANS — Refontes transversales

| Fiche | État | Titre | Preuve · note |
|---|---|---|---|
| `TRANS-01` | ✅ fermée | Sceau à deux axes sur chaque énoncé (statut × niveau) | [journal](../journal/2026-09-30-pr-02-02-vague-0.md) · sceau à deux axes (statut, niveau) |
| `TRANS-02` | ⬜ ouverte | Décomposition module × ordre du grade |  |
| `TRANS-03` | ⬜ ouverte | Tracer la frontière noyau / cible |  |
| `TRANS-04` | ⬜ ouverte | Déclarer ce qu'une passe, une représentation et un environnement doivent préserver |  |
| `TRANS-05` | ✅ fermée | Registre unique des obligations et règle de propagation | [journal](../journal/2026-09-30-pr-02-03-vague-0-fin.md) · registre des obligations produit, non tenu |
| `TRANS-06` | ⬜ ouverte | Passe de remontée : toute condition découverte en annexe qui contraint un objet du ch. 1 doit y être portée |  |
| `TRANS-07` | ⬜ ouverte | Décider quelle sémantique est primitive et dériver les deux autres |  |
| `TRANS-08` | ⬜ ouverte | Convention de réécriture : une réserve qui borne une affirmation doit réécrire l'affirmation |  |
| `TRANS-09` | ⬜ ouverte | Factoriser les obligations et non seulement les théories |  |

## ARB-PR — Arbitrages

| Fiche | État | Titre | Preuve · note |
|---|---|---|---|
| `ARB-PR-01` | ✅ fermée | Le sens de la subsomption modale | [fiche](../relectures/pr-02/taches-consolidees.md) · tranché par vérification directe (14 septembre) |
| `ARB-PR-02` | ✅ fermée | La clause de taille `i ∈ ℕ∞ ∖ {ω}` | [fiche](../relectures/pr-02/taches-consolidees.md) · tranché sur le point contesté (14 septembre) |
| `ARB-PR-03` | ⏳ à ratifier | Le traitement des effets à portée | [journal](../journal/2026-10-01-pr-02-06-theoremes.md) · position intermédiaire appliquée (ℰ_alg / ℰ_scoped) ; BIB-01 (Hefty Algebras) non instruit |
| `ARB-PR-04` | ❓ décision | Le statut du rejeu bit-à-bit | [journal](../journal/2026-10-01-pr-02-15-fusion-annexe-e.md) · instruction écrite (docs/recherche/instruction-arb-pr-04-rejeu-binaire.md) ; orientation B puis C à confirmer |
| `ARB-PR-05` | ✅ fermée | Le cadre d'ensemble du noyau minimal | [journal](../journal/2026-10-01-pr-02-07-non-interference-et-fact.md) · cadre du manuscrit ratifié |
| `ARB-PR-06` | ✅ fermée | La gravité du Th. 36 | [journal](../journal/2026-10-01-pr-02-15-fusion-annexe-e.md) · objectif déclaré : transformer la revendication en preuve ; PREUVE-02 en tête |
| `ARB-PR-07` | ✅ fermée | Socle homotopique, ou famille modale et graduée ? | [journal](../journal/2026-10-01-pr-02-15-fusion-annexe-e.md) · famille modale et graduée (1er octobre) ; motif écrit au §1.2 ; quatre imports à instruire un à un (BIB) |
