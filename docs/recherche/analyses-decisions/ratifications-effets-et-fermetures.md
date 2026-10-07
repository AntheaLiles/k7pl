<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Ratifications : effets à portée, fermetures déduites, codes d'erreur, invalidation

Éléments traités : `ARB-PR-03` (avec le cas de `BIB-01`, *Hefty Algebras*), les **sept fermetures déduites** (`PORT-08`, `PORT-16`, `REECR-02`, `-06`, `-07`, `-11`, `-25`), `FACT-09` (codes d'erreur et prémisse manquante) et `BIB-17` (sens de l'invalidation au destructeur d'une capacité exportée).

**Niveau de vérification.**

* Lecture directe du Verso aux lignes citées (`spec/Spec/C3/ReglesDeTypage.lean`, `C1/AxiomatiqueGerminale.lean`, `C1/Postulats.lean`, `C4/EchelleDuSysteme.lean`, `C5/*`, `C6/*`, `AnnexeA/*`), de `fiches-statuts.csv`, de `DECISIONS.md`, des journaux 06 et 09, de `docs/suivi/codes-et-premisses.md`, de `docs/bibliographie/verifications-pr02.md` et des fiches d'origine (`docs/relectures/pr-02/taches-consolidees.md`).
* **Je n'ai lu aucune source externe** (les corps de *Hefty Algebras*, de la RFC 5040 et des autres références ne sont pas atteignables depuis la session). Ce que j'écris de ces œuvres est ce que le manuscrit et `references.json` en disent, sous le niveau de vérification que le suivi leur donne (notice, résumé).
* Les comptes (48 codes, 17 de non-dérivabilité) ont été refaits par un petit programme sur `codes-et-premisses.md` ; **rien n'a été compilé**. Les corrections sont des textes proposés, **non appliqués**.

Portes concernées : P3 (`ARB-PR-03` appliquée, à ratifier), P2 (route des énoncés ouverts), P5 (`REECR`, anomalies).

## `ARB-PR-03` : effets à portée, `ℰ_alg` et `ℰ_scoped`, clôture faible, monoïde `ℳ`

### Ce qui a été appliqué

* Journal 06 (1er octobre 2026), §« ARB-PR-03 — il a mordu, et au bon endroit » : la mise en parallèle a montré que les deux fragments d'effets ne se comportent pas pareillement ; **position intermédiaire** retenue : nommer `ℰ_alg` et `ℰ_scoped`, écrire que la clôture est faible sur le second, garder le monoïde `ℳ`.
* Manuscrit, `ReglesDeTypage.lean:582-604` (nomenclature et clôture faible), `:606-714` (monoïde des transformateurs `ℳ = ⟨φ_n, π_S⟩`, trois lois), `:712-760` (`thm:commutation_monoide`), `:762-830` (deux projections), `:831-845` (formes normales `(n, S)`), `:847-863` (ce que le monoïde ne contient pas : pas de `φ_ℓ`), `:865-892` (ce que les couches en font), `:894-956` (réserve de modularité, mesure contre borne).
* Source : l'instruction (`ARB-PR-03` : « garder `ℰ_alg`/`ℰ_scoped` et la clôture faible ; `BIB-01` reste non instruit ») ; renforcée par la loi distributive affaiblie.
* Ce qui reste « à ratifier » (DECISIONS) : `ℰ_alg`/`ℰ_scoped` nommés, clôture faible, `ℳ` gardé ; `BIB-01` reste non instruit tant que le besoin de modularité n'est pas établi.

### Relecture critique face au manuscrit actuel

**Ce qui tient.**

* La construction est cohérente : générateurs `φ_n` (itération) et `π_S` (rétraction), trois lois (`φ_n∘φ_m = φ_{nm}`, `π_S∘π_T = π_{S∪T}`, commutation), formes normales `(n, S)` avec `φ_0` absorbant ; la décidabilité de l'appartenance à `ℳ` en découle (lu aux lignes 836-845 ; la normalisation est correcte : `φ_0∘π_S = φ_0` car `π_S(1) = 1`).
* La condition de la commutation est écrite comme une condition (aucune relation croisée dans la présentation de `ℰ₀`) ; l'hypothèse (ii) pour `n = ω` est posée comme hypothèse sur `ℰ₀`, non démontrée (`thm:commutation_monoide`) : c'est honnête.
* Le choix « mesure contre borne » et le prix (un gestionnaire qui réduit le coût n'en reçoit aucun crédit) sont écrits et cohérents avec `π†` ; `PORT-10` est consigné au postulat P3 (`Postulats.lean:134-137`).
* Le texte est explicite sur le coût de l'option retenue : le monoïde « entraîne la perte de modularité, elle ne coexiste pas avec elle » (`:908-914`) : la modularité est le prix de l'encodage, pas une impossibilité de principe ; il cite la littérature qui la rétablit (Hefty Algebras) sans l'adopter.

**Défauts relevés.**

1. **« `φ_n` est un morphisme de monoïdes » (`ReglesDeTypage.lean:638`) contredit `thm:loi_distributive_conditions`** du même chapitre. Le texte dit : « [l'itération] est un morphisme de monoïdes, ce qui est le premier fait à retenir : `φ_n ∘ φ_m = φ_{nm}` ». La justification donnée (la composition `φ_nφ_m`) établit que la **famille** `n ↦ φ_n` est un morphisme de `(ℕ∞, ·)` vers `(End(ℰ), ∘)`, non que **chaque `φ_n` est un endomorphisme du monoïde `ℰ`** : or `(εδ)^n ≠ ε^nδ^n` dès que `ε` et `δ` ne commutent pas, ce que `:1058-1069` établit. La formule `ℳ ⊆ End_mon(ℰ)` (`:653`) est ambiguë : `mon` y signifie « monotone » (la justification de `:667-669` ne parle que de monotonie) ; si on le lit « monoïde », `φ_n ∉ End_mon(ℰ)` en général. À corriger : « la famille `φ` est un morphisme de monoïdes de `(ℕ∞, ·)` dans `End(ℰ)` ; chaque `φ_n` est monotone, pas multiplicatif ».
2. **Collision de notation `ℳ`.** `ℳ` désigne le monoïde des transformateurs (`ReglesDeTypage.lean:611-653`, `eq:monoide`, `tab:deux-projections`) **et** la composante des boîtes aux lettres de la configuration `⟨𝒫 | μ | ℳ | τ⟩` (`ReglesDeTypage.lean:1468`, `SemantiqueOperationnelle.lean:159-182`). Les deux sont dans le même chapitre 3 pour le premier et dans les chapitres 3 et 4 pour le second. Le sens se retrouve au contexte, mais c'est une confusion évitable (et `𝕄` désigne en plus la monotonie, §1.4).
3. **« La clôture est faible » est une phrase de nomenclature, non un énoncé.** Le texte dit que deux opérations à portée « ne peuvent se mettre en parallèle qu'une fois leurs transformateurs appliqués » (`:588-591`). Rien ne dit ensuite ce que « faible » veut dire formellement (quelle propriété de clôture, sur quoi), ni quelle règle de typage la porte ; la composition parallèle des effets de `ℰ_scoped` n'est écrite nulle part que j'aie lue (je n'ai pas relu la règle `Par` du §3.2 en cherchant ce point). Le texte « ranger l'exception plutôt que la nier » est une décision de rédaction ; la propriété reste à énoncer.
4. **Le texte s'appuie sur *Hefty Algebras* en quatre endroits alors que `BIB-01` est « non instruite »** (voir ci-dessous, cas de `BIB-01`). La fiche `ARB-PR-03` est ratifiable sans `BIB-01` ; la ratification de « `BIB-01` reste non instruit » ne revient donc pas à ne rien affirmer, elle revient à garder des affirmations sur une source dont seule la notice a été vue.
5. **La couche 3 n'admet aucune opération à portée** (« il n'existe qu'une application de l'ensemble vide dans lui-même », `:874-877`) : vrai et élégant ; mais cela suppose `ℰ = ∅` en couche 3 (`eq:instance-L3`), ce que ch. 1 pose. Cohérent.
6. **« Les transformateurs admissibles s'emboîtent dans un autre ordre »** que les fragments de ressource (`:887-892`) : cohérent avec `PORT-15` ; non en cause.

### Alternatives écartées et pourquoi

| Alternative | Pourquoi écartée |
|---|---|
| **Unifier** `ℰ_alg` et `ℰ_scoped` sous une même machinerie, clôture forte | « Uniformisation abusive » (journal 06) : les opérations à portée ne se composent pas en parallèle comme des valeurs ; une clôture forte déclarée là où elle est faible ne pourrait plus être invoquée ailleurs |
| **Tenir les deux pour deux mécanismes étrangers** | « Oublier qu'ils partagent leur place dans le jugement » |
| **Adopter les algèbres de surcharge syntaxique** (Hefty Algebras) pour les opérations à portée | non retenue : coût d'un dispositif de résolution de nom, pour un langage qui compte déjà dix espaces de noms (`AxiomatiqueGerminale.lean:313-315`) ; et le besoin de modularité n'est pas établi |
| **Supprimer le monoïde** (laisser `f` quelconque) | rend la règle `Sc` inspectable seulement par une propriété sémantique difficile à vérifier ; le monoïde donne des formes normales décidables |
| **Admettre `φ_ℓ` dans `ℳ`** | exclue (`:857-863`) : un gestionnaire pourrait ré-étiqueter un niveau, donc déclassifier par une porte non contrôlée |

### Risque si on ratifie

Moyen. L'orientation est la bonne (la plus économe). Le risque est de ratifier avec la contradiction du défaut 1 : le chapitre dit deux choses opposées de `φ_n` selon qu'on lit le §3.2 (monoïdes) ou le §1.4/§3.2-loi distributive (pas un morphisme). Atténué par une correction de deux phrases.

### Risque si on refuse

Moyen à élevé : refuser la position intermédiaire revient soit à unifier (et à retirer la remarque de clôture faible, avec la preuve de commutation et les formes normales), soit à adopter Hefty Algebras, ce qui rouvre toute la règle `Sc`, les formes normales et la décidabilité. Aucune de ces voies n'est instruite (`BIB-01` non lue).

### Ce que la ratification débloque ou ferme

* Ferme `ARB-PR-03` → porte **P3** (« `-06` et `-07` tranchées ; `-03` et `-04` appliquées, à ratifier » : avec la ratification d'`ARB-PR-04`, P3 est levée).
* Décide de `BIB-01` : « reste non instruit » (`depend = ARB-PR-03` au CSV).
* N'agit pas sur `PREUVE-05` (loi distributive) ni sur `FACT-12` ; en revanche, le constat que `φ_n` n'est pas un morphisme est le même qui fonde « pas d'adjonction graduée unifiée » (voir `ratifications-grades-et-cadre.md`) : la cohérence des deux textes demande la correction du défaut 1.

### Verdict recommandé

**Ratifier avec correction** (défaut 1 obligatoire ; défauts 2, 3 : précisions).

### Correction minimale proposée (non appliquée)

* `ReglesDeTypage.lean:638-640`, remplacer « Et elle est un morphisme de monoïdes, ce qui est le premier fait à retenir : `φ_n ∘ φ_m = φ_{nm}`, puisque `(ε^m)^n = ε^{nm}` et `n(mk) = (nm)k` » par :

> Et la famille est un morphisme de monoïdes de `(ℕ∞, ·)` dans les endomorphismes monotones de `ℰ`, ce qui est le premier fait à retenir : `φ_n ∘ φ_m = φ_{nm}`, puisque `(ε^m)^n = ε^{nm}` et `n(mk) = (nm)k`. Chaque `φ_n` est monotone ; il n'est pas multiplicatif en général (théorème `thm:loi_distributive_conditions`), ce que le monoïde n'exige pas.

* `ReglesDeTypage.lean:653`, remplacer `End_mon(ℰ)` par `End_{\uparrow}(ℰ)` (monotones) ou le définir.
* Notation (défaut 2), si l'auteur le souhaite : renommer la composante des boîtes de la configuration (par exemple `ℬ`, ou `Mb` comme le type) ; je n'ai pas de recommandation de fond, c'est un choix de vocabulaire (à rapprocher de `T-68`).
* Clôture faible (défaut 3) : après « La clôture est donc faible sur ce fragment, et il faut l'écrire ainsi » (`:591-592`), ajouter : « (précisément : l'effet de deux opérations à portée composées en parallèle n'est défini qu'après application de leurs transformateurs à l'effet de leur argument ; il n'existe pas de produit parallèle direct de deux éléments de `ℰ_scoped`) ». **Texte conjectural : à confronter à la règle `Par`, que je n'ai pas relue pour ce point.**

### Cas de `BIB-01` : *Hefty Algebras* (Van der Rest et Bach Poulsen)

**Ce que le suivi dit.** `BIB-01`, `0 %`, « ne pas instruire tant que `ARB-PR-03` n'est pas ratifiée » (CSV : `statut ouverte`, `depend ARB-PR-03`) ; `DECISIONS.md` : « conditionnel : seulement si `ARB-PR-03` est ratifiée et le besoin de modularité établi ». `verifications-pr02.md` (ligne 72) : « `BIB-01` n'est pas instruite tant que `ARB-PR-03` n'est pas ratifiée. »

**Ce que le manuscrit en tire déjà, sans instruction** (`BIB-01` non lue : je ne vois que la notice de `references.json`) :

| Endroit | Ce qui est affirmé |
|---|---|
| `AxiomatiqueGerminale.lean:313-315` | « Le remède connu est la surcharge syntaxique, donc un dispositif de résolution de nom — prix à examiner avant d'être payé, pour un langage qui compte déjà dix espaces de noms » (clé `vanderrestHeftyAlgebrasModular2025`) |
| `ReglesDeTypage.lean:902-908` | « Les algèbres de surcharge syntaxique donnent des élaborations modulaires, composables une à une, des effets d'ordre supérieur vers les effets algébriques primitifs. La perte de modularité n'est donc pas une impossibilité de principe. » (clé `…2023`) |
| `ReglesDeTypage.lean:1018` | « un monoïde d'endomorphismes n'est pas une interface d'effet, et c'est précisément pourquoi on ne peut raffiner l'implémentation d'un gestionnaire sans recompiler » (clé `…2023`) |
| `C5/NotationsSpecialisees.lean:98-103` | « une élaboration convenablement structurée la rétablit, en se composant par cas séparés ; ce que K7PL perd ici, il le perd donc par le choix de son encodage et non par une impossibilité » (clé `…2023`) |

**Défauts de forme relevés.**

1. **Deux notices pour le même travail, citées de façon inégale.** `references.json` porte `bachpoulsenHeftyAlgebrasModular2023` (POPL 2023, DOI 10.1145/3571255, auteurs « Casper Bach Poulsen, Cas Van Der Rest », titre « … Higher-Order **Algebraic** Effects ») et `vanderrestHeftyAlgebrasModular2025` (JFP 2025, DOI 10.1017/S0956796825100142, auteurs « Cas Van Der Rest, Casper **Bach** » (sans « Poulsen »), titre « … Higher-Order Effects »). Le texte cite la première trois fois et la seconde une fois (`AxiomatiqueGerminale.lean:315`). Ce sont deux publications d'une même ligne de travail, sous deux titres, avec des notices dont l'une écorche le nom d'un auteur. Le suivi (« 2023/2025 ») le sait ; le texte ne dit pas que la seconde est la version étendue de la première (je ne le sais pas non plus : je ne vois que les notices).
2. **Niveau de vérification absent du texte.** Le manuscrit pose ailleurs des `{rmq}` pour distinguer un travail évalué d'un billet de conception (`AxiomatiqueGerminale.lean:329-331`). Pour Hefty, il écrit des phrases causales fortes (« la perte de modularité n'est donc pas une impossibilité de principe ») qui reposent sur la notice (le titre dit « modular elaboration »).

**Options pour `BIB-01`.**

| Option | Contenu | Pour | Contre |
|---|---|---|---|
| **a. Rester non instruit** (le suivi) | on garde les quatre phrases telles quelles | rien à faire ; l'argument central (le choix d'encodage est le prix de la perte) est cohérent avec le titre même du travail | les phrases s'appuient sur une source dont le corps n'a pas été lu ; la ratification d'`ARB-PR-03` les couvre implicitement |
| **b. Rester non instruit, mais étiqueter** | ajouter, à l'une des citations, « (notice et résumé lus ; corps non lu) » ou unifier les deux clés en une seule | honnête sur le niveau de vérification ; très peu coûteux | demande de choisir une clé |
| **c. Instruire maintenant** | lire le corps, vérifier que l'élaboration modulaire s'applique à la quantale d'effets et au monoïde | clôt la question de la modularité | **impossible depuis cette session** (sources bloquées) ; ne répond pas au besoin (non établi) |
| **d. Adopter Hefty Algebras** pour les opérations à portée (remplacer `ℳ` par une élaboration) | modularité des gestionnaires | rouvre la règle `Sc`, les formes normales, la décidabilité ; coûte un dispositif de résolution de nom ; le besoin n'est pas établi | coût élevé sans besoin |

**Recommandation : option b.** Ratifier « `BIB-01` reste non instruit » et mettre le niveau de vérification dans le texte (une parenthèse), plus unifier les deux clés bibliographiques ou dire laquelle est l'extension de l'autre. La question « instruire quand ? » reste conditionnée à l'établissement d'un besoin de modularité (aucun chapitre ne le formule aujourd'hui comme exigence).

**Correction minimale proposée (non appliquée).** À `ReglesDeTypage.lean:902-905`, remplacer « car la littérature ne s'arrête pas à ce constat — elle le _résout_. » par « car la littérature ne s'arrête pas à ce constat — elle le _résout_, d'après ce qu'en disent le titre et le résumé du travail cité (le corps n'est pas relu ici). » **Et** : aligner `AxiomatiqueGerminale.lean:315` sur la clé `…2023` (ou citer les deux ensemble, `{cite "…2023"}[], {cite "…2025"}[]`) ; **et** corriger la notice de `references.json` (auteur « Casper Bach Poulsen ») une fois la forme du nom vérifiée sur la source (je ne peux pas le vérifier ici).

## Les sept fermetures déduites : `PORT-08`, `PORT-16`, `REECR-02`, `-06`, `-07`, `-11`, `-25`

### Ce qui a été appliqué

* Journal 09 (1er octobre 2026). Sept fiches sont `fermee` avec `confiance = deduite` au CSV et la mention « à confirmer » : elles n'ont pas été fermées par un travail propre mais **déduites** d'une autre fiche close (les cinq `REECR` « obtenue avec `PORT-xx` » ; `PORT-08` et `PORT-16` par une requalification de statut).
* `DECISIONS.md` : « sept fermetures de fiches **déduites** … `fiches-statuts.csv`, colonne `confiance` = `deduite` ». Ce que la ratification confirme : que la déduction est valide, c'est-à-dire que le texte attendu par chaque fiche est bien présent. Ratifier = passer `confiance` de `deduite` à `journal`.

### Relecture critique face au manuscrit actuel : fiche par fiche

Chaque fiche demande une réécriture ou une requalification ; j'ai vérifié, dans le Verso, que le texte attendu existe.

| Fiche | Texte attendu (fiche d'origine) | Présent dans le Verso ? | Verdict |
|---|---|---|---|
| `REECR-02` / `PORT-02` | « pour le code compilé par K7PL » à la place de « entièrement » ; réserve en invariant ; clause (ii) du Th. 26 en exigence | **oui** : `EchelleDuSysteme.lean:37-45` (« pour le code compilé par K7PL, entièrement sur les preuves … », puis « Elle vaut du code que K7PL compile … non du code étranger que la passerelle FFI introduit ») ; `thm:revocation_ffi` en exigence | **tient** |
| `REECR-06` / `PORT-03` | énumérer les six régions, ou retirer le chiffre : « trois régions demeurent, que voici » | **oui** : `Postulats.lean:268` (« À l'exécution, trois régions demeurent, que voici. ») | **tient** |
| `REECR-07` / `PORT-10` | une phrase : le budget est une borne supérieure, écart non borné sous opérations coupantes | **oui** : `Postulats.lean:134-137` (« Le budget est une borne supérieure, et l'écart à ce que le calcul consomme effectivement n'est pas borné en présence d'opérations à portée qui coupent leur bloc ») ; `ReglesDeTypage.lean:952-956` (le prix est écrit) | **tient** |
| `REECR-11` / `PORT-05` | scinder le Th. 26 : théorème (clause 1) et exigence (clause 2) | **oui** : `thm:surete_ffi` (une clause) et `thm:revocation_ffi` (`status := "exigence"`, `level := "representation"`) | **tient** (voir `BIB-17` pour le sens de l'invalidation) |
| `REECR-25` / `PORT-11` | remplacer « équivalence sémantique » par « égalité de l'AST normalisé » ; ne pas réparer par un nouveau hash | **oui, mais déplacé** : l'annexe D (SUGOI) n'est plus dans la spécification (annexes B, C, D retirées le 6 octobre, `d84021f`) ; la clause se retrouve à `C6/CeQueLeSolveurRetourne.lean:377-381` (« identifie par un seul et même condensat deux programmes dont l'écriture diffère mais dont les arbres coïncident après normalisation … l'équivalence sémantique n'étant pas décidable ») | **tient, par un autre passage** ; la fiche cite une annexe qui n'est plus du manuscrit |
| `PORT-16` | requalifier le Th. 36 en conjecture ⟨compilation⟩ ; (ii) route de la table 1 ; (iv) reformuler le Th. 19 (`PORT-14b`) | **en partie** : `thm:abaissement_grades` est `status := "conjecture"`, `level := "compilation"` (`CeQueLeSolveurRetourne.lean:464`). **La table `tab:engagements` n'a pas de ligne pour la préservation graduée par abaissement** (les lignes sont celles de la conformité de l'abaissement au modèle mémoire, de la fidélité de l'interpréteur, etc.) ; le point (ii) de la fiche (basculer la route de « démonstration » à « dette ouverte conditionnée ») n'a donc pas de support dans la table. Le Th. 19 (`PORT-14b`) n'a pas été relu ici | **tient pour le sceau ; (ii) non vérifiable** |
| `PORT-08` | transformer le Th. 31 en **DÉFINITION** `Sens(s) = Sens(Elab(s))` ; garder trois **PROPOSITIONS** (commutation avec la substitution ; majoration des grades ; seulement des termes du noyau) ; le Th. 29 par inspection | **en partie** : voir ci-dessous | **à corriger** |

**Détail `PORT-08`.**

1. `thm:elaboration` est bien scellé `definition` (`LeTheoremeDElaboration.lean:30`). Mais son énoncé est une **implication** (`Elab(s) = t ∧ Δ ⊢ t : A | ℰ ⟹ Sens(s) = Sens(t)`), suivie d'une esquisse de preuve (`:44-52`) ; et `Sens` n'est défini nulle part (un grep de `Sens(` dans `spec/Spec` ne trouve que cet énoncé). La fiche demandait de poser `Sens(s) := Sens(Elab(s))` ; ce n'est pas écrit, de sorte que l'énoncé « définition » est toujours une formule sur un symbole non défini.
2. Les trois propositions demandées par la fiche (commutation avec la substitution, majoration des grades, seuls termes du noyau) sont dans l'esquisse (`:48-52`), pas scellées comme propositions.
3. **La phrase de la fiche « le Th. 29 est un faux corollaire » est encore dans le texte sous la forme exacte dénoncée** : `LeTheoremeDElaboration.lean:56-58` écrit « La _staticité de la syntaxe_ (théorème `thm:staticite_syntaxe`) en est un corollaire : si aucune forme de surface n'a de sens propre, aucune n'étend la grammaire du noyau. ». Or `thm:staticite_syntaxe` (`NotationsSpecialisees.lean:126-148`) a **sa propre preuve par inspection de la grammaire, en quatre points**, qui est la bonne (la fiche le dit). Le mot « corollaire » est donc faux ; il est le défaut que la fiche voulait lever.
4. L'effet de la renumérotation est correct : `thm:staticite_syntaxe` dit « à l'issue de la Phase 1 » (`NotationsSpecialisees.lean:132-133`).

### Alternatives écartées et pourquoi

* **Fermer les sept sans les vérifier** : c'est l'état actuel (`deduite`, « à confirmer »). Le risque est qu'une fiche close par déduction cache un texte manquant ; c'est le cas de `PORT-08` et, dans une moindre mesure, de `PORT-16`.
* **Les rouvrir toutes** : disproportionné, cinq sur sept tiennent.

### Risque si on ratifie

**Faible pour cinq** (`REECR-02`, `-06`, `-07`, `-11`, `-25` : texte présent). **Moyen pour `PORT-08` et `PORT-16`** : ratifier les ferme alors que (a) `Sens` reste non défini et le « faux corollaire » demeure ; (b) la table des engagements n'a pas de ligne pour l'abaissement gradué.

### Risque si on refuse

Faible : la fermeture déduite reste « à confirmer » dans le CSV ; refuser ne change rien au manuscrit, seulement le statut de confiance.

### Ce que la ratification débloque ou ferme

Passe `confiance` de `deduite` à `journal` pour sept lignes du CSV ; aucune porte n'en dépend directement (les fiches sont déjà `fermee`) ; contribue à P5 (anomalies, `REECR`) et au chiffre « 156 fermées » du tableau de bord.

### Verdict recommandé

**Ratifier en bloc les cinq `REECR`** (`REECR-02`, `-06`, `-07`, `-11`, `-25`) : texte présent, vérifié. **Ratifier `PORT-16` avec une précision** (ajouter la ligne de la table des engagements ou dire pourquoi elle n'y est pas). **Ratifier `PORT-08` avec correction** (définir `Sens`, retirer « corollaire »).

### Correction minimale proposée (non appliquée)

* `LeTheoremeDElaboration.lean:30-41` : dans l'énoncé de `thm:elaboration`, commencer par poser la définition : « `Sens(s) := Sens(Elab(s))` » ; l'implication devient une propriété immédiate, ou est retirée, et la proposition de commutation (`Elab ∘ subst = subst ∘ Elab`) est énoncée comme une proposition à part, si l'auteur veut la sceller.
* `LeTheoremeDElaboration.lean:56-58` : remplacer « La _staticité de la syntaxe_ (théorème `thm:staticite_syntaxe`) en est un corollaire : si aucune forme de surface n'a de sens propre, aucune n'étend la grammaire du noyau. » par « La _staticité de la syntaxe_ (théorème `thm:staticite_syntaxe`) s'en rapproche sans en dériver : elle se prouve directement, par inspection de la grammaire. »
* `PORT-16`, ligne manquante de `tab:engagements` (`GuideDeLecture.lean`, après la ligne de la conformité de l'abaissement) :

> | La préservation du jugement gradué par l'abaissement | §`sec:c6-ce-que-le-solveur-retourne` | Rien ; objectif déclaré (`thm:abaissement_grades`), conduit passe par passe, fragment monomorphisé d'abord | démonstration |

(texte conjectural : la route « démonstration » est celle que le §6.2 déclare ; l'auteur choisit si la ligne est souhaitée.)

## `FACT-09` : codes d'erreur et prémisse manquante

### Ce qui a été appliqué

* Séance 32 §A.5 (commit `2977b38`), `docs/suivi/codes-et-premisses.md` : table **hors manuscrit** appariant chacun des **48 codes** de l'annexe A au mécanisme qui manque (A absence de contraction ou d'affaiblissement, B indexation par la portée, C imbrication des délimiteurs, P distinction de phase, E effet, K couverture, T taille, S borne ou solveur, G graphe, H hors du jugement) ; garde de complétude dans `scripts/controles/structure.py`.
* Résultat dit négatif : l'objectif « 18 familles → 4 diagnostics » n'est pas atteint ; **17 codes sur 48** relèvent d'une non-dérivabilité structurelle (A, B, C, P).
* Décision laissée à l'auteur : ratifier l'appariement ; décider si l'annexe A reprend les quatre messages-types.

### Relecture critique face au manuscrit actuel

**Ce qui tient.**

* Les comptes sont exacts (programme refait : 48 codes, répartition A 9, B 3, C 3, P 2, E 4, K 4, T 3, S 8, G 2, H 10 ; 9 + 3 + 3 + 2 = 17). Les 48 codes du tableau sont les 48 codes que contient l'annexe A (comptage des `ERR-…` distincts dans `spec/Spec` : 48).
* La conclusion négative est honnête et suit du tableau : un mécanisme n'est pas une famille de préfixes (`MEM`, `TOP`, `TYP`, `CMP` portent chacun des mécanismes multiples).
* L'appariement est sain dans les cas contrôlés (`ERR-ARC-001` : Phase 2, tri topologique ; `ERR-SMT-001` : Phase 7 ; `ERR-TOP-001/002` : imbrication, Phase 3).

**Défauts relevés.**

1. **`ERR-TOP-011` placé « résolution des noms, Phase 4 »** et **`ERR-TYP-010` « Phase 4 »** : la Phase 4 du §6.1 est la résolution des variables d'unification (`LeProcessusDeCompilation.lean:113-122`) et ne parle pas de noms ; **la résolution des noms n'a pas de phase dans le manuscrit** (le seul passage qui l'évoque est `C5.lean:48` : « en Phase 2, après résolution des noms »). Le mot « résolution » désigne deux choses dans le pipeline, ce que `STRUCT-06` point 2 voulait déjà éviter pour « élaboration ». L'appariement reprend la confusion (Phase 4 pour des noms) sans l'avoir créée.
2. **Le tableau place `ERR-TOP-001` en Phase 3** (« vérifiée en Phase 3 ») alors que `C5.lean:48` dit Phase 2 (voir `ratifications-pipeline-et-preuves.md`, défaut 1) : le tableau corrobore la lecture « Phase 3 », c'est-à-dire qu'il faut corriger le chapitre 5.
3. **La classe H (dix codes « hors du jugement »)** est un fourre-tout : des politiques (`ERR-POL-001`), du lint (`ERR-STK-001`), du modèle mémoire (`ERR-MEM-006`, `ERR-TOP-006`), des métriques (`ERR-ARC-002`). Le texte dit que « le jugement ne les porte pas » ; il ne dit pas par quoi elles sont portées. Pas un défaut de l'appariement, une limite de ce qu'il établit.
4. **Le tableau n'est pas dans le manuscrit** (« L'annexe A n'est pas modifiée »). La fiche demandait « rattacher chaque famille de codes à la prémisse manquante » *dans l'annexe* ; la version retenue est un document de suivi. C'est la décision de l'auteur à prendre (voir ci-dessous).

### Alternatives écartées et pourquoi

* **Quatre diagnostics universels** (objectif d'origine) : non atteint, démontré par le tableau.
* **Un message-type par famille de préfixes** : faux (les préfixes ne suivent pas les mécanismes).
* **Réécrire le catalogue de l'annexe A autour des mécanismes** : non fait (aucune modification du manuscrit sans demande de l'auteur).

### Risque si on ratifie

Faible. On ratifie une table de suivi, hors manuscrit, gardée par un contrôle de complétude ; les défauts 1 et 2 relèvent de la phase attribuée, non du mécanisme.

### Risque si on refuse

Faible : le résultat négatif (objectif non atteint) serait à reprendre autrement. Aucune porte n'en dépend.

### Ce que la ratification débloque ou ferme

Ferme `FACT-09` (CSV : `depend —`). Ouvre la décision suivante : reprendre ou non les quatre messages-types à l'annexe A. Aucune porte P1–P6.

### Verdict recommandé

**Ratifier l'appariement ; reporter l'annexe A** : ne pas reprendre les quatre messages-types maintenant. Raison : le tableau établit que le résultat vaut pour 17 codes sur 48, le reste est hétérogène ; modifier l'annexe pour 35 % des codes crée une incohérence de style dans un catalogue ; et cela demande l'accord de l'auteur pour toucher à l'annexe A. Corriger l'assignation de phase des deux codes (défaut 1).

### Correction minimale proposée (non appliquée)

Dans `docs/suivi/codes-et-premisses.md` (hors manuscrit, modifiable sans mandat) : pour `ERR-TOP-011`, remplacer « résolution des noms, Phase 4 » par « résolution des noms (aucune phase ne la porte au §6.1, voir `STRUCT-06`) » ; idem pour `ERR-TYP-010` si l'unicité des instances est établie à la résolution des instances plutôt qu'à la Phase 4. Dans le manuscrit, si l'auteur le décide : une phrase au §6.1 dans le paragraphe de la Phase 3 : « La résolution des noms précède la vérification de types ; elle fait partie de l'analyse de la Phase 2. » **(texte conjectural : le rattachement exact à une phase est le choix de l'auteur.)**

## `BIB-17` : le destructeur d'une capacité exportée invalide localement l'étiquette

### Ce qui a été appliqué

* Séance 28 signale, séance 31 applique, `EchelleDuSysteme.lean:575-583` : « Le destructeur d'une capacité exportée (chapitre 3, §3.1) devrait invalider localement l'étiquette de la région qu'il a annoncée : dans ces protocoles l'invalidation s'exécute chez le propriétaire de la région, sur sa demande ou sur celle de l'accédant, et c'est l'exportateur qui est propriétaire. »
* Source : `verifications-pr02.md` (`BIB-17`) : RFC 5040 (RDMAP) définit *Send with Invalidate* ; un pair demande à la carte distante d'invalider une étiquette portant sur **la mémoire de ce pair distant** ; « le sens est à préciser » (fiche **fermée sur la source, la précision à arbitrer**). Niveau de vérification : sources citées comme pages ; **je ne les ai pas lues**.
* Au CSV, `BIB-17` est `fermee` avec la colonne `confiance` vide et la note « (à ratifier) » : un statut `fermee` qui contient « à ratifier » est incohérent avec les autres fiches (les fiches à ratifier ont le statut `a-ratifier`).

### Relecture critique face au manuscrit actuel

**Ce qui tient.**

* Le paragraphe est cohérent avec la logique de l'exigence `thm:revocation_ffi` : le typage retire une capacité, ne la révoque pas chez un pair ; c'est une exigence de la réalisation.
* « Le destructeur d'une capacité exportée » renvoie à `LeSystemeGradue.lean:307` (le destructeur est défini comme un morphisme invoqué au point de consommation) ; le renvoi existe.
* Le texte dit bien que la révocation n'est pas un théorème du langage et que sans elle « P3 cesse de valoir au-delà de la frontière ».

**Défauts relevés.**

1. **Deux descriptions du lieu de l'invalidation dans le même passage de la spécification.** Le §4.5 dit que **le propriétaire (l'exportateur, côté K7PL)** invalide localement son étiquette ; `thm:revocation_ffi` dit que « la passerelle doit invalider la référence **côté hôte** — par une table de poignées, une génération » (`EchelleDuSysteme.lean:624-626`). Les deux désignent des acteurs différents (l'hôte étranger contre l'exportateur). Si l'exportateur est K7PL, la passerelle est de son côté, et « côté hôte » désigne la référence *vue* de l'hôte (un handle) : lecture possible, mais le texte ne la fait pas.
2. **« devrait » contre « doit ».** La phrase du §4.5 emploie « devrait » (normatif faible) ; l'exigence emploie « doit ». Une exigence dont l'une des sources d'énoncé est conditionnelle est une demi-exigence.
3. **L'accédant peut demander l'invalidation** (« sur sa demande ou sur celle de l'accédant ») : alors la protection dépend d'un protocole distant, non du destructeur seul. Le texte ne dit pas ce qui se passe quand l'accédant ne demande rien : ici le destructeur seul invalide, ce qui est le sens retenu ; la demande de l'accédant est un second chemin, non requis.

### Alternatives écartées et pourquoi

| Sens | Pourquoi écarté |
|---|---|
| **Invalidation demandée par l'accédant** (le destructeur « émet une invalidation », première rédaction) | dans le protocole, la demande part de l'accédant ; le destructeur de l'exportateur n'est pas l'accédant |
| **Invalidation par l'hôte, côté hôte** | l'hôte n'est pas gouverné par le système de types |

### Risque si on ratifie

Faible : c'est la lecture qui s'accorde avec le protocole décrit. Le risque est de laisser la double formulation (défaut 1).

### Risque si on refuse

Faible : retomber sur « devrait émettre » (sens douteux selon la fiche).

### Ce que la ratification débloque ou ferme

Ferme `BIB-17` au sens du suivi (statut propre) ; soutient `thm:revocation_ffi` (`REECR-11`/`PORT-05`, `IMPL-05` fermées). Aucune porte.

### Verdict recommandé

**Ratifier avec une retouche** : aligner les deux formulations.

### Correction minimale proposée (non appliquée)

`EchelleDuSysteme.lean:624-626`, remplacer « qui doit invalider la référence côté hôte — par une table de poignées, une génération, ou un mécanisme équivalent » par « qui doit invalider, chez le propriétaire de la région (l'exportateur), l'étiquette ou la référence que l'hôte a reçue — par une table de poignées, une génération, ou un mécanisme équivalent ». Et `EchelleDuSysteme.lean:578` : « devrait invalider » devient « doit invalider ». Au CSV (décision de l'auteur, non modifié ici) : si la décision est ratifiée, renseigner `confiance` ; la fiche n'est pas `a-ratifier` au CSV et n'apparaît donc pas dans la liste des quinze.
