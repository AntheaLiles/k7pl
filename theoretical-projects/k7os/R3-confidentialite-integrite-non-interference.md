<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# R3 — Confidentialité, intégrité et non-interférence

**Statut : étude documentaire et formelle, non normative.** Base examinée : `main` à `4aea67661b049161689acb2163cfa1ebed1b5d5d` (2026-10-23). Ce rapport ne modifie ni les grades ni les règles de typage et ne déclare aucune garantie globale de sécurité acquise.

## 1. Résultat exécutif

K7PL dispose de points d'ancrage pertinents — ordre de précision, grades, règle de déclassification, capacités mémoire, sémantique d'acteurs — mais le périmètre examiné ne définit pas un système complet de contrôle des flux d'information et ne fournit pas de théorème mécanisé de non-interférence pour les programmes K7PL.

Trois propriétés doivent rester distinctes :

- **Confidentialité** : une donnée secrète ne doit pas modifier les observations autorisées d'un observateur moins privilégié, sauf libération contrôlée.
- **Intégrité** : une donnée ou un effet de confiance ne doit pas dépendre d'entrées moins fiables, sauf promotion explicitement autorisée et validée.
- **Sûreté spatiale et autorité** : un acteur ne doit pas lire ou modifier une région sans droit. C'est nécessaire mais insuffisant pour empêcher les fuites par messages, ordre, blocage, terminaison, erreurs, temps ou ressources partagées.

Un grade, même porteur d'un niveau ou d'une précision, ne constitue pas par lui-même une politique de flux d'information. Il faut définir les domaines de sécurité, la relation de flux, la propagation des étiquettes, les observations, la composition entre acteurs et les conditions de déclassement. L'annotation statique ne devient une garantie que si les règles sont formalisées et prouvées, si les points d'entrée sont couverts et si la traduction conserve la propriété.

### Conclusions prioritaires

1. **Non-interférence globale non établie.** Les schémas de C2 sont des gabarits à instancier et comportent des obligations ouvertes. Aucun théorème Lean reliant les programmes K7PL à l'équivalence d'observation de deux exécutions n'a été identifié dans le périmètre consulté.
2. **Déclassification décrite, contrôle de bout en bout non établi.** C3 mentionne une règle dédiée ; restent à vérifier son autorité, ses prémisses, sa robustesse face aux entrées adverses, sa composition et sa traduction.
3. **Intégrité et endorsement distincts.** La confidentialité ne garantit pas qu'une entrée non fiable ne puisse influencer une décision privilégiée.
4. **Les observables temporels et concurrents comptent.** Terminaison, ordre des messages, erreurs, budgets et délais peuvent révéler ou transmettre de l'information. Un énoncé portant seulement sur la valeur finale ne les couvre pas.
5. **Les modèles mémoire Lean sont abstraits.** `MemoryCapability.lean` prouve un invariant de comptage dans un modèle abstrait ; `MemoryRange.lean` établit une propriété d'intervalles naturels. Aucun ne formalise les flux d'information ni la correspondance avec l'exécution K7PL.
6. **Constant-time est une obligation relationnelle de la cible.** Un grade temporel ou un budget ne prouve pas à lui seul l'indépendance des observations de coût vis-à-vis des secrets.

## 2. Périmètre et méthode

Sources de la révision de base :

- [C1 — Postulats](../../spec/Spec/C1/Postulats.lean)
- [C2 — Adjonctions et enrichissement](../../spec/Spec/C2/AdjonctionsEtEnrichissement.lean)
- [C2 — Six schémas de métathéorie](../../spec/Spec/C2/SixSchemasDeMetatheorie.lean)
- [C3 — Système gradué](../../spec/Spec/C3/LeSystemeGradue.lean)
- [C3 — Règles de typage](../../spec/Spec/C3/ReglesDeTypage.lean)
- [C4 — Modèles de mémoire](../../spec/Spec/C4/ModelesDeMemoire.lean)
- [C4 — Échelle du système](../../spec/Spec/C4/EchelleDuSysteme.lean)
- [Modèle abstrait de capacité](../../src/K7pl/MemoryCapability.lean)
- [Arithmétique des intervalles](../../src/K7pl/MemoryRange.lean)
- [Cas d'assurance scientifique](../../wiki/assurance.md)

Il s'agit d'une lecture documentaire et statique, non d'une revue exhaustive de tous les fichiers ni d'une exécution de tests ou de preuves. Les états `under-review` et `proofsketch` du manuscrit ne sont pas assimilés à des théorèmes Lean vérifiés. L'absence d'un objet dans le périmètre consulté ne prouve pas qu'aucun travail connexe n'existe ailleurs.

## 3. Modèle de sécurité requis

Une propriété de flux d'information est relationnelle : elle compare deux exécutions du même programme, sous des entrées qui ne diffèrent que sur des données secrètes ou non fiables. Il faut définir les observations accessibles à l'adversaire et montrer que les différences interdites ne sont pas discernables.

Un contrat minimal doit fixer :

| Élément | Définition nécessaire | Question |
|---|---|---|
| Domaines | Acteurs, niveaux, compartiments et identités | Qui observe ou influence quoi ? |
| État initial | Classification et équivalence publique | Quelles différences entre exécutions sont permises ? |
| Observations | Valeurs, messages, ordre, erreurs, terminaison, coût, effets | Que peut distinguer l'observateur ? |
| Transition | État partagé, ordonnancement, communications et effets | Comment circule l'information ? |
| Politique | Relations de confidentialité et d'intégrité | Quel flux est autorisé ? |
| Déclassement | Autorité, données libérées, justification et portée | Qui peut libérer quelle information ? |
| Endorsement | Validation, provenance, autorité et portée | Quand une donnée non fiable peut-elle être promue ? |
| Composition | Acteurs, canaux, FFI, exceptions et annulation | La propriété survit-elle à la composition ? |
| Plateforme | Compilateur, runtime, noyau, pilotes, DMA et matériel | Quelles observations restent hors modèle ? |

La classification binaire « public / secret » peut être insuffisante : compartiments et relation de flux peuvent être requis. Confidentialité et intégrité sont deux axes distincts. Si les grades doivent porter ces dimensions, la spécification doit identifier les ensembles, ordres, opérateurs de combinaison et règles de sous-typage. Il ne faut pas ajouter une coordonnée avant d'avoir montré que le modèle existant ne peut pas exprimer la propriété voulue.

## 4. Forme minimale de la non-interférence

Pour une politique fixée, notons \(s_1 \approx_L s_2\) l'équivalence des états initiaux pour l'observateur \(L\), et \(\operatorname{Obs}_L(P,s)\) l'observation produite par le programme \(P\). Un énoncé de base est :

\[
s_1 \approx_L s_2 \implies
\operatorname{Obs}_L(P,s_1)=\operatorname{Obs}_L(P,s_2).
\]

Cette formule est seulement un squelette. Il faut définir \(\operatorname{Obs}\) : valeurs finales, messages, ordre, erreurs, terminaison, coût, délais et effets de bord. Pour des programmes interactifs, concurrents ou probabilistes, une trace, une relation de simulation ou une équivalence de distributions peut être nécessaire. Une simulation à sens unique ne suffit pas automatiquement à établir l'égalité des observations dans les deux sens.

### Contre-exemples discriminants

**Branchement secret et messages.** Si deux branches envoient des messages distincts sur un canal public, les exécutions se distinguent même si elles retournent la même valeur. Si les messages sont identiques mais que l'une des branches bloque ou consomme un budget différent, l'observation peut encore différer.

**Erreur dépendant du secret.**
```text
if secret then fail("A") else fail("B")
```
Aucune valeur secrète n'est retournée, mais la classe d'erreur révèle le secret si elle est visible.

**Terminaison dépendant du secret.**
```text
if secret then loop_forever() else return ()
```
Si l'observateur distingue terminaison et divergence, le programme révèle au moins un bit. Le typage ordinaire et la sûreté mémoire ne suffisent pas à exclure ce canal.

Ces exemples montrent les limites d'un contrat incomplet ; ils ne sont pas des exécutions de l'implémentation K7PL.

## 5. Confidentialité, intégrité, déclassement et endorsement

La confidentialité limite l'influence des données secrètes sur les observations moins privilégiées. L'intégrité limite l'influence de données peu fiables sur les décisions et états de confiance. Elles exigent des politiques et des preuves différentes.

Le **déclassement** autorise une libération contrôlée d'information secrète. Ce ne doit pas être un simple cast vers un niveau public : l'autorité, les valeurs ou fonctions libérables, le contexte d'appel, les interactions avec les entrées adverses et la composition de plusieurs libérations doivent être spécifiés.

L'**endorsement** autorise une donnée non fiable à contribuer à un état de confiance. Il ne doit pas être une conversion arbitraire de bas vers haut niveau. Il faut identifier le validateur, la provenance, la propriété vérifiée et la portée de l'autorité accordée.

Les travaux sur le contrôle des flux non malléable montrent que le déclassement et l'endorsement peuvent compromettre la composition naïve de la non-interférence s'ils ne sont pas contraints. Ils motivent une politique explicite plutôt que des conversions sans contrat : [Cecchetti, Myers et Arden, *Nonmalleable Information Flow Control*, CCS 2017](https://www.cs.cornell.edu/andru/papers/nmifc/).

Obligations minimales :
- définir séparément les relations de confidentialité et d'intégrité ;
- établir la propagation des deux dimensions dans les constructions et les effets ;
- rendre déclassement et endorsement explicites, limités et liés à une autorité ;
- prouver que les entrées adverses ne peuvent pas détourner ces mécanismes pour libérer plus d'information ou promouvoir des données au-delà de la politique ;
- vérifier la composition des modules et acteurs, pas seulement le typage isolé d'un module.

## 6. Ce que montrent les artefacts actuels

### C2 : ordre de précision et schémas

C2 décrit une relation de précision `\sqsubseteq` et exige la monotonie de la composition et du tenseur. Cette structure peut soutenir un raisonnement sur des raffinements, mais ne définit pas par elle-même les niveaux d'observation, les règles de flux ou l'équivalence de deux exécutions.

Dans `SixSchemasDeMetatheorie.lean`, plusieurs schémas portent l'état `under-review`, une preuve de type `proofsketch` et des obligations ouvertes. Le schéma de préservation par traduction exige de définir les jugements source et cible, les contextes et les clauses propres à chaque règle. Il ne constitue pas une preuve de non-interférence et ne peut être instancié implicitement comme tel.

### C3 : système gradué et déclassification

C3 identifie une règle de déclassification dans le système de typage. Le périmètre inspecté ne permet pas d'établir un théorème complet de non-interférence qui en tienne compte. À vérifier dans la formalisation effective :
- la définition de la règle et ses prémisses ;
- le statut de preuve des lemmes utilisés ;
- la combinaison des niveaux dans les types, effets et grades ;
- la représentation des sorties déclassifiées dans les traces ;
- la robustesse sous composition et sous entrée hostile.

Une règle locale, même prouvée admissible, ne prouve pas que toute la chaîne d'exécution respecte la politique.

### C4 : arènes, acteurs et état partagé

Le théorème textuel `thm:surete_spatiale` est marqué `under-review` et `proofsketch`. Il dépend de H1, H2 et H3 ; la note indique que H1 reste ouverte en raison de la règle d'élimination de l'arène. La conclusion demeure donc conditionnelle.

Le modèle Lean `K7pl.MemoryCapability` définit un état abstrait `Region → ℕ × ℕ`, un invariant `Unique`, une opération d'allocation et une composition parallèle. Le théorème `no_double_writer` suppose que l'état combiné satisfait déjà `Unique`. Le module précise qu'il ne formalise pas les règles opérationnelles de `Arena`, `WriteCap`, `alloc_range` ou `Par` dans le langage source. Il ne traite ni classification des secrets ni observation de traces.

`K7pl.MemoryRange` établit qu'une paire d'intervalles naturels disjoints ne représente pas le même intervalle. Son commentaire précise que la correspondance entre ces intervalles et les identités de régions/capacités K7PL reste à établir. Ce lemme arithmétique n'est pas une preuve complète de sûreté mémoire ou de confidentialité.

### Cas d'assurance

`docs/ASSURANCE.md` classe la conformité implémentation-spécification comme ouverte et distingue compilation, tests et preuves. R3 doit donc être traité comme une propriété formelle indépendante, puis relié à la sémantique, au compilateur et à la plateforme.

## 7. Temps et canaux auxiliaires

La non-interférence peut exclure les flux dans les valeurs et traces modélisées sans exclure les canaux auxiliaires physiques. Une propriété constant-time vise à rendre les observations d'exécution retenues par le modèle — branchements, accès mémoire ou temps — indépendantes des secrets, à sorties publiques équivalentes.

[Almeida et al., *Verifying Constant-Time Implementations*, USENIX Security 2016](https://www.usenix.org/conference/usenixsecurity16/technical-sessions/presentation/almeida) réduisent une politique constant-time à la sûreté d'un programme produit qui simule deux exécutions. C'est une méthode adaptée à une obligation relationnelle, y compris sur des implémentations LLVM optimisées ; cela ne prouve pas que les grades ou budgets K7PL procurent déjà cette garantie.

Une obligation constant-time K7PL doit préciser le modèle de coût, les événements observables, les entrées publiques et sorties permises, le traitement des caches, prédicteurs, spéculations, interruptions, ordonnanceur et périphériques, ainsi que la correspondance entre traces source, IR, binaire et modèle matériel.

Les preuves du noyau seL4 illustrent une revendication forte mais bornée : des propriétés d'intégrité et de confidentialité sont démontrées pour des configurations déterminées, sous hypothèses explicites. La documentation précise que les canaux temporels ne sont pas couverts par la preuve de confidentialité citée et que le DMA dépend d'hypothèses spécifiques ([preuves seL4](https://sel4.com/Verification/proofs.html), [hypothèses](https://www.sel4.org/Verification/assumptions.html)). La leçon est de borner les observations et de déclarer les hypothèses, non de supposer une confidentialité absolue.

## 8. Tests discriminants à planifier

Les scénarios suivants sont des exigences de conception ; ils ne sont pas présentés comme déjà exécutés.

| ID | Scénario | Propriété ciblée | Observation attendue |
|---|---|---|---|
| T1 | Deux exécutions diffèrent seulement sur un secret et retournent la même valeur publique | Confidentialité | Même observation publique complète, pas seulement même retour |
| T2 | Un secret change le nombre ou l'ordre des messages publics | Confidentialité | Le vérificateur détecte la différence de trace |
| T3 | Un secret choisit entre retour et divergence | Confidentialité / terminaison | Différence classée comme fuite si la terminaison est observable |
| T4 | Un secret choisit entre deux erreurs visibles | Confidentialité / erreurs | Différence détectée |
| T5 | Une entrée non fiable change un état privilégié sans validation | Intégrité | Rejet statique ou échec du contrat |
| T6 | Une entrée adversaire pilote le déclassement | Robustesse | Impossible de libérer plus que la politique autorisée |
| T7 | Un acteur tente de lire une région secrète via un alias partagé | Confidentialité / autorité | Accès refusé ou observation prouvée inoffensive |
| T8 | L'ordre des messages concurrents dépend d'un secret | Confidentialité / traces | Ordre inclus dans la politique et contrôlé |
| T9 | Un FFI conserve un alias ou modifie un buffer après retour | Intégrité / frontière de confiance | Contrat préservé ou appel refusé |
| T10 | Des états secrets équivalents produisent des durées différentes | Constant-time | L'observation temporelle respecte le modèle déclaré |
| T11 | Le déclassement est composé ou exécuté en boucle | Composition | La politique borne l'information cumulée |
| T12 | L'ordonnanceur ou un périphérique modifie la visibilité d'un événement | Périmètre système | Hypothèse explicite, confinement ou exclusion |

Un test différentiel ne prouve pas la propriété pour tous les programmes. Il sert à falsifier des hypothèses, valider l'instrumentation et tester la correspondance entre l'énoncé et le modèle.

## 9. Architecture de preuve recommandée

1. **Politique formelle** : niveaux/compartiments, ordre de flux, observateurs, équivalence des états initiaux, traces et exceptions.
2. **Sémantique relationnelle** : deux configurations ou programme produit ; inclure mémoire, acteurs, messages, erreurs, terminaison et événements de coût retenus.
3. **Théorèmes du noyau** : préservation de classification par substitution et réduction ; non-interférence pour un fragment séquentiel fermé ; lemmes distincts pour effets et exceptions.
4. **Déclassement et endorsement** : autorité, portée et robustesse ; théorèmes spécifiques.
5. **Concurrence** : équivalence des traces, événements indépendants, ordonnancement et composition entre acteurs.
6. **Frontières non sûres** : contrats FFI, pilotes, DMA, mémoire partagée et interruptions ; les frontières non modélisées restent des hypothèses.
7. **Compilation** : préserver la propriété relationnelle de la source à l'IR puis au binaire, ou utiliser une validation de traduction adaptée.
8. **Temps constant** : obligation distincte sur le modèle cible, non déduite du typage ou du seul budget.
9. **Évidence reproductible** : théorèmes Lean nommés, hypothèses visibles, liens vers les exigences normatives, tests discriminants et versions des outils/artefacts.

Commencer par un fragment fermé, séquentiel, déterministe, sans FFI ni déclassement, avec une observation publique précise ; étendre ensuite aux effets, à la concurrence et au temps. C'est une stratégie de recherche, pas une restriction normative ratifiée.

## 10. Matrice des garanties

| Revendication | État dans le périmètre consulté | Condition de clôture |
|---|---|---|
| Ordre de précision C2 | Décrit dans le manuscrit | Vérifier propriétés algébriques et instances |
| Confidentialité par non-interférence | Théorème global non identifié dans le périmètre | Relation d'exécution, observables et preuve de composition |
| Intégrité des données de confiance | Théorème global non identifié dans le périmètre | Politique d'intégrité, provenance, endorsement et preuve |
| Déclassement robuste | Règle décrite ; garantie de bout en bout non établie | Autorité, sémantique, robustesse, composition et traduction |
| Sûreté spatiale par capacités | Énoncé sous revue ; prémisses ouvertes ; modèle Lean abstrait | Relier règles effectives, capacités et exécution ; fermer H1–H3 |
| Confidentialité des communications | Propriété relationnelle de trace non identifiée dans le périmètre | Modèle de canaux et preuve d'équivalence des traces |
| Confidentialité temporelle | Non établie | Modèle de coût/plateforme et preuve constant-time |
| Garantie sur le binaire | Dépend du chantier R2 | Préservation des propriétés relationnelles source-cible |
| Absence de fuite par DMA / matériel | Non établie | Modèle matériel, IOMMU ou pilote de confiance, hypothèses vérifiées |

## 11. Obligations et critère de clôture

### P1 — avant toute revendication globale
- [ ] Ratifier les observables : valeurs, messages, ordre, terminaison, erreurs, ressources et temps.
- [ ] Identifier les domaines de sécurité et les ordres de confidentialité et d'intégrité.
- [ ] Définir l'autorité et les contraintes de déclassement et d'endorsement.
- [ ] Construire un énoncé relationnel Lean pour un fragment minimal.
- [ ] Définir les exclusions : canaux temporels/physiques, DMA, ordonnanceur, FFI et matériel hors modèle.

### P2 — après fermeture du noyau relationnel
- [ ] Prouver la préservation de la politique sous réduction et substitution.
- [ ] Étendre la propriété aux effets et traces de messages.
- [ ] Ajouter T1–T12 comme tests différentiels.
- [ ] Relier la sémantique de sécurité à la traduction de R2.
- [ ] Évaluer les canaux temporels sur une cible définie avec mesures reproductibles.

R3 ne peut être clos que lorsqu'un énoncé formel nomme acteurs, données, observables, exceptions et hypothèses ; qu'une preuve machine établit le théorème sur un périmètre explicite ; et que les frontières FFI, runtime, noyau et matériel sont couvertes ou exclues sans ambiguïté. Une CI documentaire verte ne satisfait pas ce critère.

## 12. Sources externes

- Almeida, Barbosa, Barthe, Dupressoir et Emmi, [*Verifying Constant-Time Implementations*](https://www.usenix.org/conference/usenixsecurity16/technical-sessions/presentation/almeida), USENIX Security 2016.
- Cecchetti, Myers et Arden, [*Nonmalleable Information Flow Control*](https://www.cs.cornell.edu/andru/papers/nmifc/), CCS 2017.
- [seL4 — preuves de sécurité](https://sel4.com/Verification/proofs.html).
- [seL4 — hypothèses des preuves](https://www.sel4.org/Verification/assumptions.html).

---
**Conclusion :** les fondations de K7PL offrent des points d'ancrage pour une future preuve de flux d'information. Confidentialité, intégrité, non-interférence et résistance aux canaux auxiliaires restent des obligations distinctes jusqu'à ce que leurs énoncés, preuves et correspondances avec l'exécution soient établis.
