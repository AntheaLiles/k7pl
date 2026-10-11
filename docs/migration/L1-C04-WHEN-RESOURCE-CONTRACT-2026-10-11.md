<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C-04 — contrat de When, ψ et consommation budgétaire

**État :** AUDIT DE MIGRATION NON NORMATIF — C-04 OUVERT  
**Révision source examinée :** `main`, SHA `414ce6a1d2347de11397002980f3e0fe0b1e8205`  
**Périmètre :** C-04, avec dépendance explicite à C-05 ; aucune modification de `spec/` ni de `src/`.

Ce document confronte le texte normatif aux notes des séances 55 et 59–62. Il ne transforme ni les notes de séance en preuve, ni une conception proposée en décision de l’autrice. Les cas ci-dessous sont des discriminants et des attentes conditionnelles, pas une suite de tests normatifs déjà ratifiés. Depuis sa rédaction, l’autrice a ratifié P3-B le 11 octobre 2026 : la latence d’attente appartient à l’orchestrateur et non au coût d’exécution de l’automate déclenché. Cette décision ne prouve pas le contrat de ressources et ne ferme pas C-04, qui reste PARTIEL / NON CLOS.

Sources principales : [règle When en C3, révision auditée](https://github.com/AntheaLiles/k7pl/blob/414ce6a1d2347de11397002980f3e0fe0b1e8205/spec/Spec/C3/ReglesDeTypage.lean#L483-L538), [interface de coût en C2](https://github.com/AntheaLiles/k7pl/blob/414ce6a1d2347de11397002980f3e0fe0b1e8205/spec/Spec/C2/ComonadeExponentielleEtFragments.lean#L160-L255), [axiomatique C1](https://github.com/AntheaLiles/k7pl/blob/414ce6a1d2347de11397002980f3e0fe0b1e8205/spec/Spec/C1/AxiomatiqueGerminale.lean), [registre C](L1-THEORY-OBJECTS.md), [sédimentation L1](L1-THEORY-SEDIMENTATION.md).

## 1. Constats textuels : ce que les sources disent effectivement

### 1.1 La règle normative When

La règle actuellement écrite dans C3 a la forme suivante :

> Prémisses : Δ₁ ⊢ v : ◇V ; □Δ₂, x :ᵣ V ⊢ c : ◇C | ε.  
> Conclusion : Δ₁ ⊠₁ (□Δ₂) ⊢ when x = v in c : ◇C | ε[ω/k].

Trois faits sont directement lisibles dans la source :

1. le contexte de continuation est exigé sous □ ; c’est la condition de reportabilité temporelle ;
2. l’effet de conclusion est transformé par ε[ω/k] ;
3. la conclusion écrite n’ajoute pas explicitement une prémisse Adm, un appel à Consume, ni une application de ψ.

Le sous-indice de la composition du contexte est ici 1. Les notes de la séance 59 écrivent au contraire Δ₁ ⊠ε Δ₂ = Δ₁ + ψ(Δ₂, ε). Ces deux notations ne doivent pas être tenues pour identiques sans une définition ou un lemme de correspondance : l’effet qui indexe la composition, son emplacement exact et son rapport à l’effet de conclusion restent à relier.

### 1.2 La notation de l’effet non borné

L’explication de C3 présente ε[ω/k] par la saturation de la composante temporelle : ⟨φ, κ⟩[ω] = ⟨φ, ⊤⟩, avec ⊤(ℓ) = ω pour tout niveau ℓ.

Les séances 55 et 59–62 écrivent la famille correspondante sous la forme κω(ℓ) = ⟨ω, ω⟩. C2 décrit ensuite la famille temporelle comme κ : ℒ → (ℕ∞ × ℕ∞), dont les deux coordonnées sont agrégées par W et D.

Cette correspondance est plausible sous l’ordre produit point par point : le maximum d’un couple est ⟨ω, ω⟩. Elle n’est cependant pas écrite comme une fonction typée reliant l’expression de C3 au porteur de C2. Il manque donc une clarification explicite sur le fait que le ⊤ de C3 est bien le maximum du produit des deux coordonnées, et non seulement une famille scalaire. Sans cette relation, l’égalité Cost_Budget(κω) = ω repose sur une identification de porteurs encore implicite.

### 1.3 Signature et définition de Cost_Budget dans C2

Le bloc normatif de C2 expose littéralement une signature partielle :

> Cost_𝔅 : (ℕ∞ × ℕ∞)^ℒ ⇀ ℕ∞  
> Consume(β, κ) := β ⊖ Cost_𝔅(κ)  
> condition d’admissibilité : β = ω ou Cost_Budget(κ) ≤ β.

Plus loin, C2 définit W comme le supremum des sommes finies des wℓ, D comme le supremum des sℓ, puis écrit Cost_𝔅(κ) = Cost_Budget(κ) = max(W(κ), D(κ)). Les sources emploient ainsi plusieurs noms — Cost_𝔅, Cost_B et Cost_Budget — sans établir dans chaque occurrence s’il s’agit d’alias ou d’objets distincts.

Si ℒ est un ensemble, si les valeurs des coordonnées sont dans la chaîne complète ℕ∞ et si sup ∅ = 0, alors W et D sont définies pour toute famille κ de type (ℕ∞ × ℕ∞)^ℒ ; leur maximum est donc total sur ce porteur. La formule max(W,D) ne fournit, à elle seule, aucune restriction qui justifierait la flèche partielle de la signature. La flèche partielle peut exprimer une restriction réelle de domaine, mais cette restriction n’est pas nommée dans le bloc qui donne la formule.

### 1.4 ψ, Adm et Consume

C2 décrit ψ dans ses esquisses comme le transport de l’effet sur le contexte : elle préserve les composantes d’usage, de monotonie et de niveau, et agit sur la composante de budget par ⊖. Les notes de la séance 59 donnent la formule de composition Δ₁ ⊠ε Δ₂ = Δ₁ + ψ(Δ₂, ε), puis placent Adm et Consume au passage de l’effet par ψ.

Ces notes proposent un contrat plus précis que la règle When elle-même, mais elles ne suffisent pas à établir que les deux notations de composition ont le même type, que le domaine de ψ est celui voulu, ni que chaque règle qui compose les contextes invoque ce transport. La signature exacte de ψ, son domaine, sa condition de partialité et la manière dont un effet ε fournit la famille κ évaluée par Cost_Budget doivent être écrits explicitement.

### 1.5 Sens de ⊖

Les sources de conception contemporaines de C-04 emploient la soustraction tronquée prolongée par ω : pour β = ω, le résultat reste ω, y compris dans le cas ω ⊖ ω = ω ; pour β fini et un coût qui dépasse β, l’opération arithmétique donne 0. Ce n’est pas le résidu de l’addition, qui donnerait ω ⊖ ω = 0. Les documents historiques contiennent aussi l’ancienne lecture en termes de résidu ; elle ne doit pas être reprise sans contrôler la version normative exacte.

La distinction sémantique est essentielle : si β est fini et Cost_Budget(κ) > β, le résultat arithmétique 0 ne doit pas rendre l’usage admissible. Adm doit empêcher Consume et le franchissement de contexte ; ⊖ ne remplace pas le contrôle d’admissibilité. La convention ω ⊖ ω = ω est une convention de borne/potentiel, pas l’affirmation qu’un budget infini est une quantité exacte dont on a calculé le reste.

Sources de cette distinction : [séance 54 — admissibilité budgétaire](https://github.com/AntheaLiles/k7pl/blob/414ce6a1d2347de11397002980f3e0fe0b1e8205/docs/history/2026-10-07-pr-02-54-budget-admissibility-closure.md), [séance 59 — résolution de When](https://github.com/AntheaLiles/k7pl/blob/414ce6a1d2347de11397002980f3e0fe0b1e8205/docs/history/2026-10-07-pr-02-59-when-budget-resolution.md), [séance 60 — agrégateurs](https://github.com/AntheaLiles/k7pl/blob/414ce6a1d2347de11397002980f3e0fe0b1e8205/docs/history/2026-10-07-pr-02-60-canonical-cost-aggregators.md).

## 2. Contrat à établir, règle par règle

Les clauses suivantes constituent un contrat de preuve proposé. Elles décrivent ce qu’il faudrait pouvoir vérifier si l’autrice ratifie le contrôle différé par ψ ; elles ne réécrivent pas la règle normative.

### C-04.1 — Introduction de When

**Conditions nécessaires.** Les deux prémisses de la règle C3 doivent être typées ; le contexte de continuation doit être reportable sous □. Il faut préserver la substitution explicite de l’effet ε[ω/k], sans l’effacer ni la remplacer par une borne finie.

**Type d’effet après When.** Le résultat doit exposer la perte de borne. Si le porteur de C2 est le produit (ℕ∞ × ℕ∞)^ℒ, il faut prouver que la transformation de C3 induit bien κω(ℓ) = ⟨ω, ω⟩. Cette conséquence ne doit pas être obtenue par une simple ressemblance de notation.

**Ce que la règle n’établit pas en l’état.** Elle ne dit pas que l’effet est immédiatement consommé, ne montre pas l’appel de ψ et ne prouve pas qu’une continuation sous □ possède nécessairement un budget β = ω. Reportabilité et admissibilité budgétaire sont deux obligations distinctes.

### C-04.2 — Passage de l’effet par la composition de contexte

Sous le contrat différé proposé par les séances 59–62, ψ est l’unique opération qui applique le coût temporel à un budget de contexte. Sa signature candidate minimale serait une opération partielle de transport d’un couple (contexte, effet) vers un contexte transformé ; cette notation est à confirmer, pas une signature déjà normative.

Pour chaque liaison dont le budget est affecté, il faut préciser :

1. comment l’effet ε détermine la famille κ évaluée par Cost_Budget ;
2. quel budget β est testé et quelle liaison le porte ;
3. si Adm est évaluée liaison par liaison, pour tout le contexte, ou selon une règle de partage différente ;
4. quelles composantes du grade restent inchangées ;
5. que ψ est indéfinie lorsque le budget fini ne peut supporter le coût, plutôt que de retourner un contexte au budget 0 ;
6. que chaque composition de contexte utilisée par les règles passe par cette opération avec le bon effet.

La formule proposée par les notes, Δ₁ ⊠ε Δ₂ = Δ₁ + ψ(Δ₂, ε), ne prouve pas ces propriétés : elle donne la forme de l’interface à préciser.

### C-04.3 — Adm

Si Cost_Budget est totale, le prédicat est bien typé comme Adm : ℕ∞ × K → Prop, avec K = (ℕ∞ × ℕ∞)^ℒ. Il accepte un coût κ exactement lorsque le budget est infini ou que le coût n’excède pas le budget. Dans ce cas, puisque ω est le maximum de ℕ∞, le premier disjoint β = ω est logiquement redondant, mais peut être conservé comme cas explicite de présentation.

Si Cost_Budget est partielle, la définition écrite est insuffisante : pour β = ω, Adm est vraie par le premier disjoint même lorsque Cost_Budget(κ) n’est pas défini. Consume demeure alors indéfinie. Il faut soit prouver la totalité de Cost_Budget, soit introduire explicitement l’appartenance à son domaine dans Adm.

### C-04.4 — Consume

Sous une signature totale de Cost_Budget, le domaine de Consume est l’ensemble des couples (β, κ) qui satisfont Adm(β, κ). Sur ce domaine seulement, Consume(β, κ) = β ⊖ Cost_Budget(κ).

Sous une signature partielle de Cost_Budget, le domaine doit être restreint aux couples tels que κ ∈ Dom(Cost_Budget) et Adm(β, κ) ; la définition de Adm doit porter la même condition de domaine. Dans les deux lectures, un coût inadmissible ne doit pas être rendu admissible au seul motif que ⊖ renverrait 0.

Pour un budget infini et un coût infini, la convention de soustraction choisie donne ω ⊖ ω = ω. La conséquence est que Consume conserve ici la borne infinie ; elle ne représente donc pas une mesure exacte de ressource consommée. Cette lecture peut convenir à une borne/potentiel, mais elle doit rester compatible avec l’invariant que la preuve de correction entend établir.

### C-04.5 — Cost_Budget et dépendance C-05

C-05 doit établir, sur le porteur exact, les définitions de W et D, leur totalité, les conventions de supremum, leur monotonie et les lois de composition invoquées. C-04 peut utiliser ces résultats, mais ne doit pas les remplacer par la dérivation sur papier de la séance 60.

Sous les hypothèses explicites que ℒ est un ensemble, que ℕ∞ est une chaîne complète avec sup ∅ = 0 et que κ est une fonction totale dans (ℕ∞ × ℕ∞)^ℒ :

- W(κ) = sup des sommes finies des coûts de travail ;
- D(κ) = sup des coûts de profondeur ;
- Cost_Budget(κ) = max(W(κ), D(κ)) est totale ;
- pour κω(ℓ) = ⟨ω, ω⟩, W(κω) = D(κω) = Cost_Budget(κω) = ω.

Si ces hypothèses ne sont pas celles que le texte normatif veut retenir, le domaine alternatif doit être énoncé ; la flèche partielle n’est pas une preuve en soi de cette alternative.

## 3. Cas discriminants et attentes conditionnelles

Ces cas servent à départager les lectures. Ils ne doivent être convertis en tests normatifs qu’après ratification de la lecture correspondante. Les attentes ne sont donc pas des résultats acquis.

| Cas | Données | Lecture avec coût d’exécution P3-A et contrôle différé | Lecture avec latence externe P3-B | Obligation discriminée |
|---|---|---|---|---|
| T1 — coût nul | β = n fini ; κ = 0 | Adm vraie ; Consume doit conserver n | Même résultat pour la composante de coût d’exécution | Neutralité de ⊖ et de ψ |
| T2 — frontière exacte | β = n ; Cost_Budget(κ) = n | Adm vraie ; Consume vaut 0 | Dépend de la projection du coût retenue | Cas d’égalité dans Adm |
| T3 — dépassement fini | β = n ; Cost_Budget(κ) = n + 1 | Adm fausse ; ψ et la composition sont indéfinies. Le 0 arithmétique de ⊖ ne doit pas être utilisé | Refus si le coût d’exécution dépasse n ; la latence externe ne suffit pas, à elle seule, à décider | Séparation du garde-fou Adm et de ⊖ |
| T4 — When local | When produit un effet non borné, sans franchissement établi d’un budget fini | Avec le contrôle différé, l’effet peut rester local si les prémisses et □ sont satisfaites ; sa borne infinie demeure visible, et tout franchissement ultérieur d’un budget fini échoue | Possible seulement si la représentation distingue latence et coût d’exécution ; l’effet ne peut être silencieusement réduit à un coût fini | Introduction versus consommation |
| T5 — When traverse un budget fini | β fini ; κω(ℓ) = ⟨ω, ω⟩ | Cost_Budget = ω ; Adm fausse ; ψ indéfinie | Le passage peut être admissible seulement si la latence est exclue explicitement de la fonction de coût consommée | Choix P3 et domaine de ψ |
| T6 — When traverse un budget infini | β = ω ; κ = κω | Adm vraie si Cost_Budget est définie ; Consume vaut ω selon la convention ω ⊖ ω = ω | L’effet de latence doit être conservé comme observation même si la consommation d’exécution est finie ou nulle | Totalité, convention d’infini et sens de la borne |
| T7 — travail infini réparti | ℒ dénombrable ; wℓ = 1 et sℓ = 0 à chaque niveau | W = ω par supremum des sommes finies ; D = 0 ; coût scalaire ω | Même coût d’exécution si ces wℓ sont des travaux réels ; l’attente externe n’est pas nécessaire pour obtenir ω | Définition de W, support infini |
| T8 — profondeur seule | Un niveau avec wℓ = 0 et sℓ = ω | W = 0 ; D = ω ; coût scalaire ω | Une attente externe ne doit être comptée dans D que si P3 le décide | Distinction travail/profondeur/latence |
| T9 — ensemble de niveaux vide | ℒ = ∅ | Si sup ∅ = 0 est ratifié, W = D = Cost_Budget = 0 ; sinon la totalité revendiquée n’est pas établie | Même obligation de domaine pour la composante d’exécution | Convention de supremum et signature de Cost_Budget |
| T10 — signature partielle | κ ∉ Dom(Cost_Budget), β = ω | La définition actuelle d’Adm retourne vrai par β = ω mais Consume reste indéfinie : contrat incohérent tant que le domaine n’est pas gardé | Même incohérence si la fonction est conservée partielle | Signature totale ou garde de domaine |
| T11 — contexte reportable, budget fini | Une liaison de □Δ₂ porte β fini | □ ne suffit pas à rendre le budget infini ; le passage doit être refusé par ψ si le coût est ω | La reportabilité est satisfaite, indépendamment du coût d’exécution, si la sémantique les sépare | Absence d’implication établie entre □ et β = ω |
| T12 — transformation de l’effet | C3 utilise ε[ω/k] ; C2 exige une famille de couples | Il faut prouver la correspondance vers κω(ℓ) = ⟨ω, ω⟩ avant le calcul Cost_Budget | Il faut en outre préciser quelle coordonnée encode la latence externe | Cohérence de porteuses, C-04/C-05 |

### Contre-exemples aux raccourcis incompatibles

- **« □ implique un budget infini ».** Aucun lien de ce type n’est formulé dans la règle examinée. Il faut un théorème ou une restriction de typage ; sinon un contexte reportable avec β fini reste un cas pertinent.
- **« Saturer par ω consomme automatiquement le budget ».** La transformation de l’effet produit une annotation non bornée ; elle ne constitue pas en elle-même une application de Consume. Cette lecture confond introduction et franchissement.
- **« ⊖ ramène toujours le dépassement à zéro, donc le passage est sûr ».** Faux dans le contrat différé : si Adm est fausse, ψ doit être indéfinie. Le zéro de la troncature ne vaut pas certificat d’admissibilité.
- **« La formule max rend vraie la signature partielle ».** Sans domaine explicite, au contraire : si W et D sont totales sur le porteur indiqué, max(W,D) l’est aussi. Une restriction partielle doit correspondre à une hypothèse vérifiable.
- **« L’attente externe est seulement une latence, alors le même κω peut être consommé avec un coût fini ».** Si κω a effectivement les deux coordonnées ⟨ω,ω⟩ et Cost_Budget = max(W,D), son coût scalaire vaut ω. P3-B exige une séparation formelle entre latence observée et coût d’exécution ; elle ne peut garder simultanément la même fonction de coût sur le même porteur.

## 4. Décision P3 — axe ratifié, interfaces restantes ouvertes

### Axe P3 : que borne le budget ?

**P3-A — option non retenue.** Cette lecture imputait la latence d’attente au coût temporel budgété de l’automate. Elle est conservée ici comme provenance de l'arbitrage de la séance 55, pas comme option encore ouverte après la ratification de P3-B.

**P3-B — ratifiée par l’autrice le 11 octobre 2026.** `When` est un déclencheur réactif, distinct de `case` : il surveille l’environnement et lance une séquence d’actions à la survenue d’un événement. L’orchestrateur agrège les surveillances de son environnement connu et lance les automates ad hoc. Une attente peut durer indéfiniment ; sa latence est attribuée à l’orchestrateur, non au coût d’exécution de l’automate déclenché.

Cette décision établit l’intention sémantique de la séparation, mais **ne choisit pas** comment la représenter dans les objets mathématiques. Il reste à définir une représentation typée séparant latence observée et coût d’exécution (coordonnées distinctes, projection ou autre interface justifiée), leur composition, la frontière temporelle du déclenchement et les budgets de l’orchestrateur et de l’automate. La famille de C3 `ε[ω/k]` ne peut pas être assimilée silencieusement au coût d’exécution de l’automate tant que cette correspondance n’est pas définie.

La séance 59 propose une vérification d’admissibilité différée via `ψ`/`Adm`/`Consume`. La ratification de P3-B ne confirme pas à elle seule ce détail opératoire : il faut encore préciser si, quand et sur quel contexte le coût de l’automate est consommé, et distinguer cette consommation de la durée d’attente de l’orchestrateur.

### Ne pas confondre la structure temporelle avec la décision budgétaire

La condition □Δ₂ porte sur la reportabilité du contexte. La transformation ε[ω/k] / κω porte sur la représentation de la non-borne temporelle. Le choix P3-A/P3-B porte sur la question distincte de savoir si cette latence fait partie du coût d’exécution borné. Conserver □ comme modalité existante, ou retenir la famille temporelle κω, ne tranche pas à lui seul la lecture budgétaire A/B.

### Axe de signature : Cost_Budget est-elle totale ?

Cet axe est indépendant de P3 :

- **COST-TOTAL.** Déclarer Cost_Budget : K → ℕ∞ sur tout K = (ℕ∞ × ℕ∞)^ℒ, avec la complétude de ℕ∞ et sup ∅ = 0 ; unifier les noms Cost_𝔅, Cost_B et Cost_Budget. La partialité est alors portée par Consume/ψ et le prédicat Adm.
- **COST-PARTIELLE.** Donner un domaine D_Cost précis et sa justification ; restreindre Adm à κ ∈ D_Cost ; définir Consume uniquement quand κ ∈ D_Cost et Adm est vraie. La formule max(W,D) doit alors être définie seulement sur D_Cost, ou expliquer quelle hypothèse échoue hors de ce domaine.

La première option est celle que la formule max supporte directement sous les hypothèses de totalité indiquées. La seconde reste possible si une restriction intentionnelle du porteur est démontrée. Aucune n’est appliquée ici.

### Décision d’autrice ratifiée et choix techniques encore ouverts

**Décision ratifiée le 11 octobre 2026 : P3-B.** L’attente environnementale et la surveillance des événements relèvent de l’orchestrateur ; le budget d’exécution de l’automate déclenché ne comptabilise pas cette latence préalable.

Restent à trancher ou à spécifier avant la fermeture de C-04 :

1. **COST-TOTAL** ou **COST-PARTIELLE**, avec domaine exact et hypothèses explicites le cas échéant ;
2. la représentation mathématique de la latence observée séparée du coût d’exécution, sans présumer qu'une coordonnée supplémentaire ou une projection est déjà choisie ;
3. le contrat de `ψ` : paramètres typés, domaine, unité de coût, liaison(s) affectée(s), précondition `Adm`, résultat `Consume`, frontière de déclenchement et règle de composition invoquant ce transport ;
4. la convention normative de `⊖`, notamment `ω ⊖ ω = ω`, et sa distinction d’avec un résidu d’addition ;
5. le modèle de l’orchestrateur : agrégation des surveillances, lancement d’automates ad hoc, interaction des budgets et garanties éventuellement visées (ordre, équité, réarmement, événements multiples). Ces garanties ne sont pas ratifiées par la seule description fonctionnelle ci-dessus.

## 5. Preuve attendue pour fermer C-04

### Contrat de preuve après ratification de P3-B

La preuve doit séparer deux phénomènes : (a) l’attente/observation d’un événement par l’orchestrateur, qui peut être non bornée, et (b) le coût d’exécution de l’automate lancé à la survenue de cet événement. Elle doit établir que :

- le déclenchement conserve la latence observée sans la convertir en coût d’exécution de l’automate ;
- le budget de l’automate est appliqué à son exécution dans le périmètre formellement défini, sans imputer l’attente préalable ;
- aucune consommation réelle de l’automate n’est omise ou rendue admissible par la seule séparation de la latence ;
- `ψ`, `Adm` et `Consume` opèrent sur la grandeur de coût retenue, dans des domaines explicites, et chaque règle qui compose les contextes invoque le contrat correct ;
- le modèle exprime comment l’orchestrateur agrège les événements connus et lance les automates ad hoc, sans lui attribuer des garanties d’ordre, d’équité ou de réarmement qui n’auraient pas été décidées ;
- la relation entre `ε[ω/k]` dans la source C3, la latence observée et le porteur temporel de C2 est typée et démontrée ;
- les conversions et la substitution préservent cette séparation, en coordination avec C-06.

La représentation précise de latence et de coût n’est pas encore choisie : la preuve ne doit ni supposer une composante supplémentaire, ni postuler une projection non définie.

### Dans les deux cas

La fermeture exige la signature et les domaines explicites, la preuve des propriétés de C-05 effectivement utilisées, la vérification de toutes les règles qui invoquent la composition de contexte, les cas de bord du tableau ci-dessus, la compatibilité avec la substitution C-06 et la ratification de l’autrice. Une compilation Lean, un test arithmétique, une CI verte ou une dérivation sur papier ne remplace aucun de ces éléments.

## 6. Fichiers concernés et changement minimal autorisé

**Documentaire, maintenant :**
- ce dossier C-04 ;
- le lien depuis la section C-04 de L1-THEORY-OBJECTS.md.

**Normatif, uniquement après ratification :**
- spec/Spec/C1/AxiomatiqueGerminale.lean : contrat de composition de contexte et statut de l’interface budgétaire ;
- spec/Spec/C2/ComonadeExponentielleEtFragments.lean : signature et domaine de Cost_Budget, définitions de W/D et de Consume ;
- spec/Spec/C3/ReglesDeTypage.lean : relation explicite entre When, l’effet ε[ω/k], le sous-indice de ⊠, ψ et la condition d’admissibilité ;
- la formalisation Lean et les contrôles arithmétiques qui invoquent effectivement ces définitions, après inventaire des cibles exactes.

Aucun changement normatif n’est autorisé par le présent dossier. Ne pas modifier les sources pour « rendre les signatures cohérentes » avant la réponse d’autrice.

## 7. Critère de clôture C-04

C-04 demeure OUVERT tant que les six conditions suivantes ne sont pas satisfaites :

1. la correspondance entre ε[ω/k] et κω(ℓ) = ⟨ω,ω⟩ est typée ;
2. les signatures et domaines de Cost_Budget, ψ, Adm et Consume sont compatibles ;
3. le rôle de ⊖, notamment au cas ω ⊖ ω, est explicite dans la source normative ;
4. P3-B est ratifiée ; la distinction coût/latence est effectivement reflétée dans le modèle et dans les interfaces typées ;
5. la preuve règle par règle exclut tout franchissement inadmissible et établit l’absence de coût masqué ;
6. les obligations dépendantes de C-05 et C-06 sont prouvées ou conservées explicitement ouvertes sans prétendre fermer C.

Ce dossier ne clôt ni C-04 ni l’étape C. Il rend les décisions et preuves manquantes contrôlables.
