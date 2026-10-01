# Mise en conformité — les vingt-huit instructions dérivées de la relecture GPT

9 septembre 2026. Chaque point de GPT est ici traduit en **instruction
exécutable** : ce qu'il faut écrire, où, ce que cela remplace, et le contrôle
qui empêche la régression.

Les relevés de Gemini viennent en appui lorsqu'ils précisent un lieu ou une
forme. **En cas de conflit, GPT fait foi** — la règle vaut notamment pour
l'exponentielle, où Gemini recommande l'inverse.

Les faux positifs déjà écartés — GPT 10 et GPT 12 — ne reçoivent pas
d'instruction ; leur part utile est reversée en I-11 et I-14.

---

## 0. La clef qui rend tout le reste actionnable

GPT numérote les théorèmes d'après le document imprimé ; nous les étiquetons.
**Les quarante-quatre numéros tombent exactement sur nos étiquettes**, dans
l'ordre du document. Voici les vingt qu'il cite.

| GPT | Étiquette | Nom |
|---:|---|---|
| 1 | `thm:terminaison_couche_3` | terminaison de la couche 3 par algèbre initiale |
| 3 | `thm:productivite_couche_2` | productivité coinductive de la couche 2 |
| 4 | `thm:progression_polarisee` | progression, paramétrée par la couche |
| 8 | `thm:raffinement` | structure de raffinement |
| 12 | `thm:deadlock_acyclique` | absence de blocage mutuel par acyclicité |
| 14 | `thm:preservation_type` | préservation du type |
| 15 | `thm:isomorphisme_memoire` | correspondances de disposition, transfert zéro-copie |
| 16 | `thm:surete_spatiale` | sûreté spatiale par capacités linéaires |
| 17 | `thm:determinisme_rejeu` | déterminisme du rejeu |
| 18 | `thm:liberte_initialisation` | liberté d'initialisation par graphe topologique |
| 20 | `thm:surete_ffi` | sûreté de l'interface étrangère par passerelle de capacité |
| 21 | `thm:traduction_metalangage` | la traduction préserve le typage |
| 24 | `thm:hygiene` | hygiène des expansions |
| 25 | `thm:expansion_macro` | la règle d'expansion est dérivable |
| 26 | `thm:interface_jugement` | l'interface d'une unité de compilation est son jugement |
| 28 | `thm:abaissement_grades` | l'abaissement préserve le jugement gradué |
| 30 | `thm:boxtimes_addition` | la composition généralise l'addition ponctuelle |
| 33 | `thm:coherence_axiome` | cohérence de φ et ψ |
| 34 | `thm:substitution` | substitution sur trois niveaux |
| 35 | `thm:substitution_simultanee` | substitution simultanée |
| 36 | `thm:preservation` | préservation |
| 41 | `thm:commutation_traduction` | commutation de la traduction et de la substitution |

**Sans cette table, aucune de ses recommandations n'est applicable.** Elle est à
verser à `meta/` : la prochaine relecture externe partira du même document
imprimé.

---

# LOT A — Les six corrections de fond

Elles corrigent ce qui est faux. Rien d'autre ne doit passer avant.

## I-01 — La structure de Kleisli graduée *(GPT 1.1)*

**Le fait, vérifié mot pour mot au chapitre 2 :**

> « Hom_{𝒞_{!_r}}(A,B) := Hom_𝒞(!_r A, B) ; l'identité n'existe qu'en r = 1, où
> elle est ε_A. La composition de f : !_r A → B avec g : !_s B → C produit un
> morphisme de 𝒞_{!_{r×s}}. »

Sans identité par objet et sans composition interne, ce n'est pas une catégorie.

**Instruction.**

1. Écrire au chapitre 2, à la place de la construction actuelle :
   > La famille 𝐊𝐥_ℛ = (Hom^r(A,B))_{r ∈ ℛ}, où Hom^r(A,B) := Hom_𝒞(!_r A, B),
   > est une **structure de Kleisli graduée** : elle a les objets de 𝒞, une
   > composition Hom^r(A,B) × Hom^s(B,C) → Hom^{r×s}(A,C), et une identité au
   > seul grade neutre. Ce n'est pas une catégorie pour chaque grade — c'en est
   > une pour r = 1, et le fragment cartésien r = ω en est une autre.
2. Remplacer partout « catégorie de co-Kleisli de grade r » par « structure de
   Kleisli graduée » ; conserver « catégorie de co-Kleisli » **au seul cas
   cartésien**, où il est exact et où Δ_ω le dénote déjà.
3. Poser `Hom^r(A,B)` comme notation unique et retirer `𝒞_{!_r}`.

**Ce que cela absorbe.** GPT compte une quarantaine de paragraphes qui
reconstruisent une catégorie à chaque grade et parleront désormais d'une seule
structure.

**Contrôle.** `𝒞_{!` interdit hors du cas ω.

## I-02 — Séparer les grades des indices de taille *(GPT 1.2)*

**Le fait.** ℛ est défini comme ℚ≥0 ∪ {ω}, puis déclaré « le type des conaturels
ℕ∞ ». Ce ne sont pas les mêmes porteurs. Trois lecteurs indépendants l'ont
relevé — GPT, la formalisation Lean de Gemini qui code ℛ en conaturels, et
l'analyse B par la bien-fondation.

**Instruction.**

1. Poser au chapitre 2 :
   > ℛ_usage = (ℚ≥0 ∪ {ω}, +, ×, 0, 1, ≤) porte les grades ; les fractions y sont
   > requises par les capacités de lecture divisées du chapitre 3.
   > ℕ∞ ⊂ ℛ_usage est le sous-semi-anneau des conaturels. **Tout indice de
   > taille est pris dans ℕ∞ privé de ω**, seul fragment dont l'ordre strict
   > soit bien fondé.
2. Retirer l'affirmation « ℛ est le type des conaturels » : elle est vraie du
   sous-semi-anneau, fausse du porteur.
3. Reprendre les deux théorèmes de progression, qui invoquent la bien-fondation
   sans l'avoir bornée.

**Ce que cela ferme.** L'inconsistance connue des types dimensionnés d'Agda
vient d'une plus grande taille réflexive ; K7PL ajoutait à ce risque un ordre
non bien fondé sur la partie rationnelle. Les deux tombent ensemble.

**Contrôle.** « conaturel » et « ℚ≥0 » ne doivent jamais désigner le même objet
à moins de trois cents signes.

## I-03 — Aligner le déterminisme du rejeu sur P4 *(GPT 7)*

**Le fait.** P4 énonce « toute exécution distribuée de K7PL est rejouable bit à
bit ». Le théorème 17 conclut « un état final identique bit à bit ». Or le
chapitre 1 écrit déjà, en remarque :

> « Le rejeu *bit à bit* suppose en outre un ordonnancement, un mode d'arrondi
> flottant et une version de compilateur identiques, **qu'aucune clause de ce
> document ne fixe et que le journal ne consigne pas**. »

La preuve donnée — le pli des événements est pur et référentiellement
transparent — établit le déterminisme fonctionnel, non l'identité binaire.

**Instruction.** Scinder en deux, et faire passer la restriction du statut de
remarque à celui d'hypothèse.

> **Théorème 17 — déterminisme logique du rejeu.**
> Rejeu(J(H), S₀) ≈_obs H, où ≈_obs est l'équivalence observationnelle des états.
>
> **Corollaire 17.1 — identité binaire, sous environnement reproductible.**
> Sous l'hypothèse E_repro — ordonnancement, mode d'arrondi et version de la
> chaîne de compilation identiques — Rejeu(J(H), S₀) =_bit H.

Puis réécrire P4 : « toute exécution distribuée est rejouable ; le rejeu est
logique par construction et binaire sous E_repro. »

**Ce que cela gagne.** Le postulat cesse de promettre ce que le document dit
ailleurs ne pas tenir. C'est le second point le plus sérieux de la relecture.

## I-04 — Le graphe d'attente n'est pas le graphe de dépendances *(GPT 6)*

**Le fait, et il est plus net que GPT ne le dit.** Deux théorèmes portent la
même hypothèse et l'un promet beaucoup plus que l'autre :

- Théorème 18 : « la phase d'**initialisation** atteint un état entièrement
  câblé sans interblocage : Acyclique(G) ⟹ ∃ un tri topologique. »
- Théorème 12 : « Alors N **n'atteint jamais** d'état de blocage mutuel. »

Le second est un énoncé sur toute l'exécution ; sa preuve est celle du premier.
Or le manuscrit distingue lui-même les dépendances de construction des
dépendances d'attente.

**Instruction.**

1. Écrire l'invariant manquant, et le nommer :
   > **Lemme de simulation du graphe d'attente.** Pour tous acteurs a, b, si a
   > attend b à l'exécution, alors l'arête (a,b) est au graphe de dépendances :
   > wait(a,b) ⟹ dep(a,b). Par conséquent Acyclique(G_dep) ⟹ Acyclique(G_wait).
2. Le théorème 12 s'en déduit ; sa preuve devient une ligne.
3. Si le lemme ne se démontre pas — un acteur peut attendre un message d'un
   pair dont il ne dépend pas structurellement —, **renommer le théorème 12**
   pour qu'il ne promette que l'initialisation, et inscrire la différence en
   réserve.

**C'est la seule instruction du lot A dont l'issue n'est pas acquise.** Elle
demande d'établir un fait sur le langage, non de corriger une formulation.

## I-05 — Le hachage n'est pas une égalité *(GPT 9)*

**Le fait.** Trois erreurs en une phrase du chapitre 4 : « BLAKE3, déterministe
et **sans collision**, qui réduit l'égalité structurelle et la déduplication à
une comparaison d'entiers en **O(1)** ». Et une quatrième au chapitre 6, où le
hachage de l'arbre normalisé « identifie deux programmes syntaxiquement
distincts mais **sémantiquement équivalents** ».

**Instruction.**

1. Chapitre 4 :
   > L'arène en calcule un condensat cryptographique (BLAKE3), déterministe et
   > **résistant aux collisions**. La comparaison de deux condensats déjà
   > calculés est en O(1) ; le calcul du condensat sur une structure de taille n
   > est en O(n). Sous l'hypothèse de résistance aux collisions, l'égalité des
   > condensats **vaut égalité structurelle** ; le langage l'admet comme
   > hypothèse cryptographique déclarée, non comme théorème.
2. Chapitre 6 : remplacer « sémantiquement équivalents » par **« syntaxiquement
   équivalents après normalisation »**. Un condensat d'arbre normalisé décide
   l'égalité canonique ; l'équivalence sémantique n'est pas décidable.
3. Ajouter l'hypothèse cryptographique à la liste des engagements — c'en est un,
   et il n'y figure pas.

**Contrôle.** « sans collision », « injectif » et « unique » interdits à moins de
deux cents signes d'un hachage.

## I-06 — Le postulat P1 n'exige pas l'inversibilité *(GPT 8)*

**Le fait.** P1 affirme que toute optimisation « qui se formule comme un
isomorphisme naturel — fusion de boucles, mise en ligne, défonctionnalisation —
est sémantiquement transparente par construction ». Or une transformation de
compilation n'est pas généralement un isomorphisme : elle peut être une
simulation, une équivalence observationnelle, un homomorphisme. Le chapitre 5
fait d'ailleurs lui-même la distinction pour la défonctionnalisation.

**Instruction.** Réécrire P1 :

> Toute optimisation admise est accompagnée d'un **morphisme de correction
> sémantique** dans 𝒞 ; lorsque ce morphisme est un isomorphisme, l'équivalence
> est immédiate, et c'est le cas de la fusion de boucles et de la mise en ligne.

**Ce que cela gagne.** La correction du compilateur cesse de dépendre de
l'inversibilité, qui n'était ni nécessaire ni vraie.

---

# LOT B — Les sept théorèmes-schémas

C'est le cœur de ce que GPT apporte, et la partie que la relecture appelle
« distillation ». **Chaque schéma remplace plusieurs démonstrations par une
instanciation.**

## I-07 — Le théorème fondamental de compatibilité de l'action graduée *(GPT 20)*

**Le fait.** Une même loi se rencontre au moins quatre fois, et le manuscrit la
signale à chaque fois sans jamais la nommer :

> « rencontrée ici pour la **deuxième** fois » — « pour la **troisième** fois » —
> « l'est ici pour la **quatrième** fois » — « La loi de cohérence y apparaît une
> **troisième** fois »

Les comptes ne concordent pas, et pour cause : plusieurs compteurs
indépendants courent en parallèle. La loi est le théorème 33,
`thm:coherence_axiome`, démontrée en annexe.

**Instruction. C'est la plus rentable du document.**

1. **Remonter le théorème 33 au chapitre 2**, avec sa démonstration, sous le
   nom :
   > **Théorème — compatibilité de l'action graduée.**
   > Pour tout grade r, tout contexte Δ et tout effet ε :
   > **r · ψ(Δ, ε) = ψ(r · Δ, φ_r(ε))**
   > La mise à l'échelle d'un contexte commute avec le transport de l'effet.
2. L'étiqueter `thm:action_graduee` et garder `thm:coherence_axiome` en alias
   pour ne casser aucun renvoi.
3. **Supprimer les quatre annonces de comptage.** Chaque emploi devient
   « par le théorème de compatibilité de l'action graduée ». Rien d'autre.

**Ce que cela absorbe.** Les quatre re-expositions dans la substitution, la
relation logique, la traduction et les macros. Gemini estime le gain à deux
pages ; le gain réel est ailleurs — le lecteur cesse de croire qu'une
coïncidence se répète et voit un théorème s'appliquer.

## I-08 — Le lemme-schéma de commutation *(GPT 5.3 et 13)*

**Le fait.** Le théorème 24 énonce (Mθ)[σ] = (M[σ])θ, commutation entre
métasubstitution et substitution objet. Le théorème 41 énonce
⟦c[v/x]⟧ ≡ (νx)(⟦c⟧ | x⟨⟦v⟧⟩), commutation entre substitution et traduction.
**Ce ne sont pas les mêmes théorèmes, mais c'est le même schéma**, et le
manuscrit le dit — « La forme de cet énoncé se rencontre ici pour la troisième
fois. C'est une commutation entre deux niveaux. »

**Instruction.** Poser au chapitre 2, en section de métathéorie :

> **Lemme-schéma de commutation.** Soit T une opération de transformation
> (expansion, désucrage, traduction, abaissement) définie par récurrence sur la
> structure des termes et respectant les liaisons. Alors
> **T ∘ subst = subst ∘ T**, à renommage près des variables liées.
>
> *Esquisse.* Par récurrence sur le terme. Le seul cas non immédiat est celui du
> lieur, où l'hygiène de T fournit la fraîcheur requise.

Puis :

- théorème 24 → **instance** du schéma, pour l'expansion ;
- théorème 41 → **instance** du schéma, pour la traduction ;
- le désucrage et l'abaissement deviennent des instances sans démonstration
  propre.

## I-09 — Le schéma de préservation par traduction *(GPT 5.4 et 14)*

**Le fait.** Le théorème 21 est la préservation par traduction vers le
métalangage ; le théorème 28 est la préservation graduée par abaissement.
GPT insiste, et il a raison : **il ne faut pas les fusionner**, ils ne couvrent
pas le même objet. Mais leurs preuves suivent le même chemin, que le manuscrit
réutilise sans l'abstraire.

**Instruction.** Poser :

> **Schéma de préservation par traduction.** Soit ⟦·⟧ : Source → Cible une
> traduction, et soit chaque règle de la source l'image d'une **dérivation** de
> la cible. Alors ⟦·⟧ préserve le jugement :
> D_s : Δ_s ⊢ t_s ⟹ D_t : Δ_t ⊢ ⟦t_s⟧.
>
> *Esquisse.* Par récurrence sur D_s ; chaque règle fournit sa dérivation image
> par hypothèse, et la composition des dérivations est admissible dans la cible.

Le théorème 21 et le théorème 28 deviennent deux instanciations, chacune se
réduisant à **exhiber la dérivation image de chaque règle** — ce qui est le
travail réel, et ce que la mécanisation devra porter de toute façon.

**Bénéfice pour la phase LEAN 4.** Le schéma se formalise une fois ; les deux
instances deviennent des tables de correspondance règle par règle.

## I-10 — Le lemme topologique commun *(GPT 5.5)*

**Instruction.** Extraire, au chapitre 4 :

> **Lemme.** Tout graphe fini acyclique admet un tri topologique.

Puis le théorème 18 en est l'application à l'initialisation, et le théorème 12
en est l'application au graphe d'attente **une fois I-04 acquise**. Les deux
preuves cessent de réexécuter le même argument.

**Ordre.** I-04 avant I-10 : sans le lemme de simulation, le théorème 12 n'a pas
de graphe auquel appliquer celui-ci.

## I-11 — Le lemme générique de capacité *(GPT 26, item 16)*

**Le fait.** Le théorème 16 est la sûreté spatiale par capacités linéaires ; le
théorème 20 est la sûreté de l'interface étrangère par passerelle de capacité.
Même argument : la détention est la seule voie vers l'accès, et la linéarité
interdit la duplication de la détention.

**Instruction.** Poser :

> **Lemme de capacité.** Si l'accès à une ressource r n'est dérivable que d'une
> liaison portant Cap(r), et si Cap(r) est de grade linéaire, alors deux accès
> concurrents à r n'ont pas de dérivation.

Le théorème 16 en est l'instance pour la mémoire, le théorème 20 pour la
frontière étrangère. **Cette factorisation absorbe aussi la part utile de la
critique écartée sur le transfert zéro-copie** : ce que le théorème 15 doit
établir, c'est une identité de tampons sous hypothèses, et l'absence de course
lui vient du lemme de capacité, non de la disposition mémoire.

## I-12 — Le théorème d'élaboration *(GPT 16 et 17)*

**C'est l'exemple que tu as relevé, et il mérite le traitement le plus complet.**

**Le fait.** Le théorème 25 dit déjà de la règle d'expansion :

> « La règle Expand n'est pas un axiome du système : elle se dérive du lemme de
> substitution appliqué n fois, et sa cohérence est celle du théorème 33. »

C'est juste, et c'est un cas particulier. Le chapitre 5 répète la même thèse
sous six noms — macro ordinaire, glyphe, sucre syntaxique, `bind-to`,
R-expressions et X-expressions, notation sans point — et à chaque fois le texte
écrit une variante de « ce n'est pas une primitive nouvelle ».

**Instruction.**

1. Poser au chapitre 5, en ouverture, le théorème unique :

   > **Théorème d'élaboration.** Soit Elab : Surface → Noyau la fonction
   > d'élaboration. Pour toute forme de surface s,
   > **Elab(s) = t ∧ Δ ⊢ t : A | ℰ ⟹ Sens(s) = Sens(t)**
   > — la forme de surface a exactement le sens du terme de noyau qu'elle
   > élabore, et n'a pas d'autre sens.
   >
   > *Esquisse.* Elab est définie par récurrence sur la syntaxe de surface et
   > n'émet que des termes du noyau. Sa correction est celle du lemme-schéma de
   > commutation (I-08) appliqué à Elab, et sa cohérence celle du théorème de
   > compatibilité de l'action graduée (I-07).

2. **Corollaire immédiat, qui est le théorème 25 :** une macro n'ajoute rien au
   noyau.
3. Les six formes du chapitre 5 deviennent **six lignes d'une table** — nom,
   forme de surface, image dans le noyau — et non six paragraphes.
4. Supprimer les six variantes de « ce n'est pas une primitive nouvelle ». Le
   théorème le dit une fois pour toutes.

**Ce que cela absorbe.** GPT estime plusieurs dizaines de lignes de
justifications locales ; le vrai gain est que **la staticité de la syntaxe
devient un corollaire** au lieu d'être une thèse répétée. Et les copatrons de la
décision B, s'ils étaient un jour élaborés plutôt que primitifs, tomberaient
sous ce même théorème.

## I-13 — La garantie par inexpressibilité *(GPT 19)*

**Le fait.** Six occurrences, dans trois chapitres, du même geste — et le
manuscrit s'en aperçoit sans le nommer :

> « les courses de données ne sont donc pas détectées, elles sont rendues
> inexprimables » — « la discrimination n'est pas interdite, elle est
> inexprimable » — « une obligation indécidable ne soit pas rejetée mais
> inexprimable. **C'est la même figure que la règle des éliminateurs du
> chapitre 3, et elle a le même bénéfice.** »

**Instruction.** Définir une fois au chapitre 1, à côté de la condition de
clôture :

> **Garantie par inexpressibilité.** Une violation est dite *inexprimable*
> lorsque le terme qui la commettrait n'a pas de dérivation — non parce qu'une
> règle l'interdit, mais parce qu'aucune règle ne le produit. La garantie est
> alors une propriété de la grammaire et du jeu de règles, et non d'une
> vérification.

Puis les cas deviennent quatre lignes : inexpressibilité de la duplication, de
la capture, du franchissement de couche, de l'accès à une capacité absente.

**Pourquoi au chapitre 1.** Le geste commande la doctrine du langage entière ;
le laisser émerger au chapitre 5 le fait passer pour une astuce de syntaxe.

---

# LOT C — Distiller, homogénéiser

## I-14 — Le fragment de théorie effectivement décidé *(GPT 12, part utile)*

Le manuscrit **déclare déjà** la dette : « Toutes sont décidables […] leur
combinaison ne l'est pas nécessairement, et le document ne caractérise pas le
fragment sur lequel il se restreint. » Ce n'est donc pas une incohérence, et
l'instruction n'est pas une correction mais une clôture d'engagement.

**Instruction.** Nommer l'objet et trancher :

> Soit 𝒯_K7PL la combinaison des théories employées — arithmétique linéaire sur
> les grades fractionnaires, tableaux, fonctions non interprétées. Le
> compilateur ne traite que le fragment 𝒯₀ ⊆ 𝒯_K7PL défini par ⟨…⟩ ; toute
> obligation hors de 𝒯₀ est **rejetée avec un code d'erreur**, jamais soumise.

Sans quoi la borne de terminaison de la phase de résolution reste une
affirmation sans objet.

## I-15 — Les effets indexés, et la frontière qui les sépare *(GPT 13)*

**Le fait.** Le manuscrit dit que les grades peuvent dépendre de valeurs à
condition qu'elles soient closes à la compilation, et nomme cela « dépendance
pragmatique » contre « dépendance complète ». Le vocabulaire est le nôtre et
n'a pas de répondant dans la littérature — où les monades graduées indexées
modélisent précisément les effets dont les annotations dépendent des valeurs.

**Instruction.** Reformuler la frontière en termes de **moment**, non de degré :

> Un indice **clos à la compilation** : le grade dépend d'une valeur, et cette
> valeur est connue avant l'exécution. K7PL l'admet.
> Un indice **dépendant d'une valeur d'exécution** : K7PL ne l'admet pas, et la
> réserve porte sur ce seul cas.

**Pourquoi c'est important pour ton lectorat.** Sans cette reformulation, un
pair lit « K7PL n'a pas d'effets dépendants » alors que le langage en possède la
forme statique — et le crédite d'une limite qu'il n'a pas.

## I-16 — Les opérations à portée, une définition et des instances *(GPT 14, appuyé par Gemini)*

**Le fait.** La distinction est bonne et la littérature la soutient : les
opérations à portée se modélisent par des théories algébriques paramétrées, non
par les seules opérations algébriques. Mais Gemini relève un défaut de conduite
que GPT ne voit pas : **le corps du texte pose une piste que l'annexe dément**.
Le chapitre 1 annonce une monade graduée indexée ; l'annexe démontre qu'il faut
un monoïde de transformateurs d'effets.

**Instruction.**

1. Poser au chapitre 2 une seule définition : **opération algébrique ordinaire**
   contre **opération à portée**, la seconde paramétrée par un état de portée.
2. Porter la conclusion de l'annexe — le monoïde ℳ — **dans le corps du texte**,
   et supprimer la fausse piste. Un document qui propose puis dément fait
   travailler le lecteur pour rien.
3. Les exemples — `StreamContext`, blocs, ressources de portée — deviennent des
   instances citées, non des discussions locales.

## I-17 — Les cinq mots-clés de preuve *(GPT 15)*

**Le fait.** Le manuscrit énonce lui-même l'équivalence, et jusqu'à la raison :
« une vérification construite ailleurs pour une autre raison ». `pure` exige
ℰ = ∅ ; `terminates` exige une mesure décroissante ; `event` est la
productivité ; `contract` des pré et postconditions déjà présentes ; `logic` un
guidage de la résolution.

**Instruction.** Les traiter comme une famille d'attributs et écrire une seule
phrase :

> Les attributs `@pure`, `@terminates`, `@event`, `@contract`, `@logic` ne sont
> pas des mécanismes. **Chacun est la projection nommée d'une obligation que le
> jugement porte déjà**, et sert à la réclamer là où le contexte ne l'impose
> pas.

Puis une table de cinq lignes : attribut, obligation projetée, lieu de la
vérification. Les cinq paragraphes disparaissent.

## I-18 — Les trois préservations, nommées séparément *(GPT 18)*

**Le fait.** Le manuscrit fait déjà l'analyse juste — le théorème 14 couvre
l'évaluation et l'abaissement sans les grades, le théorème 36 les grades sans
l'abaissement, le théorème 28 l'intersection. Mais le théorème 14 est formulé
comme s'il couvrait l'abaissement, alors que sa preuve le traite en isomorphisme
naturel.

**Instruction.** Nommer les trois, et montrer leurs intersections :

| Nom | Étiquette | Couvre |
|---|---|---|
| Préservation_évaluation | `thm:preservation` | grades, évaluation |
| Préservation_effacement | *(à écrire)* | grades, effacement |
| Préservation_abaissement | `thm:abaissement_grades` | grades, abaissement |

Le théorème 14 devient le cas non gradué, et **la dette devient visible** au
lieu d'être masquée par un énoncé trop large. Gemini ajoute la bonne forme :
réécrire le théorème 14 sur les configurations ⟨c | μ | τ⟩, en conformité avec
le théorème 36.

## I-19 — La boucle du pipeline, et son théorème *(GPT 11)*

**Le fait.** La figure donne huit étapes linéaires, dont Résolution → Optimisation
→ Production. Le texte reconnaît ensuite que l'optimisation crée de nouvelles
contraintes de grade et conclut : « la conduite correcte est d'itérer les deux
phases jusqu'à stabilisation ». Le modèle dessiné contredit le modèle défendu.

**Instruction.** Remplacer la suite linéaire par une boucle et un théorème :

> **Théorème de stabilisation du pipeline.** La boucle
> Vérification → Optimisation → Vérification termine sous un budget de
> spécialisation fini.
>
> *Esquisse.* Chaque tour consomme au moins une unité du budget de
> spécialisation, qui est fini et décroissant ; le cas de la mise en ligne est
> déjà traité au chapitre 6.

Le manuscrit a **déjà** le budget et la mesure décroissante. Il ne lui manque
que l'énoncé qui les emploie.

**Ce que cela absorbe.** Plusieurs paragraphes de justification, et la
numérotation à décimales que Claude signale — 1, 1.5, 2, 2.5 — qui n'existe que
pour loger dans une suite linéaire ce qui est une boucle.

## I-20 — Ne pas factoriser les tests *(GPT 24)*

**C'est le seul point où GPT demande de la retenue, et il faut l'entendre.**

Le chapitre 6 pose : test unitaire = raffinement vérifié, test d'intégration =
vérification du graphe, test de résilience = arbre de supervision. La
factorisation est séduisante et **trop forte** : un test d'intégration éprouve
des propriétés que la structure statique n'exprime pas, et un arbre de
supervision est une structure de contrôle, non la propriété de résilience.

**Instruction.** Conserver les trois correspondances comme **des recouvrements
partiels**, et garder la restriction que le manuscrit énonce déjà plus loin —
le test de propriétés reste nécessaire, et l'oracle de référence demeure une
hypothèse de confiance. Écrire « couvre » et non « est ».

**Pourquoi cela compte.** Une factorisation abusive coûte plus cher qu'une
redite : elle fait passer pour démontré ce qui est espéré.

---

# LOT D — Normaliser la notation

## I-21 — L'exponentielle porte la ressource *(GPT 2 — et GPT l'emporte sur Gemini)*

**Le conflit, tranché.** Gemini demande de remplacer partout `!_r` par `□_r`.
GPT demande l'inverse. **GPT fait foi**, et la raison est bonne : le carré porte
aujourd'hui trois foncteurs — ressource, confidentialité, temps — qui n'ont ni
le même rôle ni la même métathéorie.

**Instruction.** Table normative, et une seule :

| Objet | Glyphe | Motif |
|---|---|---|
| modalité de ressource | **`!_r A`** | glyphe de l'exponentielle linéaire depuis Girard ; un pair le lit sans apprendre |
| classification | **`Sec_ℓ A`** | nommé, donc non ambigu |
| temps | **`○A`, `□_t A`, `◇_t A`** | le carré modal a son meilleur titre du côté de la nécessité |

Gemini a néanmoins raison sur un fait : **le manuscrit emploie déjà les deux**,
`!_r` au chapitre 2 et `□_r` en annexe. La passe est donc une passe de
remplacement de `□_r` vers `!_r`, et non l'inverse.

**Note pour la décision A1.** La duale de ◇ y prend son nom : `□_t`. Gemini l'a
retrouvée indépendamment et la nomme ainsi.

**Contrôle.** `□` non indicé par t interdit hors du chapitre sur la
confidentialité.

## I-22 — Le contexte du jugement est Δ, sans exception *(GPT 3, appuyé par Gemini)*

**Le fait, compté à la source : trois occurrences de `\Gamma \vdash`.** Deux au
chapitre 2, une au chapitre 3.

La première est légitime — « un jugement Γ ⊢ t : T n'est rien d'autre qu'un
morphisme t : Γ → T de 𝒞 » est l'emploi catégorique que le chapitre 1 autorise.
Les deux autres ne le sont pas : la garantie de gradualité statique et le
théorème 14.

**Instruction.** Poser la règle stricte, puis l'appliquer :

> **Δ** est le contexte du jugement K7PL, **toujours**.
> **Γ** ne désigne qu'un contexte catégorique ou métathéorique, **jamais** une
> zone du jugement.

Gemini donne la correction exacte pour le lieu le plus délicat, la tranche
minimale du chapitre 3 : `Δ ⊢ C at d ⊳ Δ'[m]`, les liaisons cartésiennes étant
identifiées par le grade ω dans Δ_ω plutôt que par une seconde zone.

**Contrôle.** `\Gamma \vdash` interdit hors du chapitre 2 — trois lignes, et
c'est clos pour toujours.

## I-23 — L'effet et l'échappatoire *(GPT 3)*

**Le fait.** ℰ dénote l'effet composé ; 𝔈 dénote l'ensemble d'échappatoires du
théorème de divulgation délimitée. Cinq occurrences. Dans un système qui
superpose effets, obligations, événements et capacités, deux fontes du même E ne
suffisent pas à distinguer deux objets.

**Instruction.** ℰ reste l'effet ; l'ensemble d'échappatoires devient **𝒳**.

## I-24 — Le grade, le mode, l'intervalle, le fragment *(GPT 1.3 et 22)*

**Le fait.** Le chapitre 3 pose une distinction utile — « un grade est une
valeur ; une modalité est un domaine de valeurs » — puis quatre niveaux
circulent sous des noms qui se recouvrent, auxquels s'ajoute la structure de
Kleisli. Et le texte dit lui-même que l'idéal de contraction et le booléen
d'affaiblissement **ne sont pas des composantes de grade**.

**Instruction.** Table normative :

| Niveau | Notation | Ce que c'est |
|---|---|---|
| grade | r, q | un élément de ℛ = ℛ₁ × … × ℛ_n |
| mode | M = (ℛ, K, W) | une algèbre, un idéal de contraction, un booléen d'affaiblissement |
| intervalle admissible | I(M) | le domaine de grades que le mode autorise |
| fragment | F_M | le sous-langage engendré |
| structure de Kleisli graduée | 𝐊𝐥_ℛ | l'objet sémantique *(I-01)* |

**Conséquence à tirer, et elle est belle.** Le théorème 10 cesse d'être une
« inclusion d'intervalles qui vaut sous-typage » et devient ce qu'il est : **un
théorème sur des morphismes de modes**. Son nom actuel — « la chaîne modale est
une chaîne de morphismes de modes » — le dit déjà ; c'est l'énoncé qui doit
suivre.

Et la question « trois modes ou quatre » se dissout : *la construction engendre
quatre modes ; K7PL en instancie trois, dont l'ordre est le fragment totalement
ordonné du treillis.*

## I-25 — Séparer les deux ordres *(Claude A2, que GPT recoupe)*

Le chapitre 2 pose ⊑ comme relation de précision et écrit Unr ⊑ Aff ⊑ Lin ; le
chapitre 3 écrit Lin <: Aff <: Unr pour le sous-typage. **Deux ordres inverses
l'un de l'autre sur certaines composantes, sous des glyphes voisins.**

**Instruction.** Deux glyphes visuellement disjoints — ⊑ pour la précision, ≼
pour le sous-typage — et la table du produit mixte remontée au chapitre 2, là où
l'ordre est introduit.

## I-26 — La table de normalisation, et son caractère normatif *(GPT 27)*

**Instruction.** Écrire au chapitre 1 une table unique, et la déclarer
**normative** : aucune section ne peut introduire une variante locale.

| | Objet |
|---|---|
| Δ | contexte gradué |
| ℛ | semi-anneau des grades |
| r, q | grades individuels |
| M, I(M), F_M | mode, intervalle admissible, fragment |
| A, B, C | types |
| t, c | termes, calculs |
| ε, ℰ | effet individuel, effet composé |
| 𝒳 | ensemble d'échappatoires |
| φ_r, ψ_r | action du grade sur l'effet, sur le contexte |
| ⊠_ε | composition de contextes sous effet |
| !_r | modalité de ressource |
| Sec_ℓ | classification |
| ○, □_t, ◇_t | temps |
| ⟦−⟧ | traduction |
| Γ | contexte catégorique ou métathéorique **seulement** |

**Le point qui fait tout le travail** est le dernier mot du titre : *normative*.
Une table descriptive documente la divergence ; une table normative l'interdit.

## I-27 — La taxonomie des statuts *(GPT 25, appuyé par Claude D1)*

**Le fait.** Le chapitre 1 distingue rigoureusement postulat, théorème,
engagement, lecture — et déclare que « là où aucun de ces quatre mots
n'apparaît, l'énoncé est une conséquence de ce qui précède ». Or le document
emploie ensuite **réserve** une trentaine de fois, plus *obligation*, *exigence*
et *condition*. Une réserve n'est pas une conséquence.

**Instruction.** Deux voies, et je recommande la première.

- **Étendre à sept mots** — postulat, théorème, engagement, lecture, réserve,
  obligation, exigence — chacun défini en une ligne. La taxonomie existante
  fonctionne ; il lui manque trois entrées qu'elle emploie déjà.
- Ou adopter la nomenclature que GPT propose — Théorème, Conjecture,
  Affirmation d'implantation, Hypothèse d'ingénierie. Plus courte, mais elle
  jette une distinction que le document a mis du temps à gagner.

**Contrôle.** Tout énoncé du corps porte l'un des sept mots, ou est une
conséquence — vérifiable par comptage.

## I-28 — Cesser d'annoncer ce qui vient d'être écrit *(GPT 28)*

**Le fait, et c'est le diagnostic le plus fin de la relecture.** Le manuscrit
explicite une idée, puis explicite qu'elle a déjà été explicitée : « ce n'est
pas un mécanisme nouveau », « cela n'ajoute rien à l'appareil », « c'est la même
loi », « cette loi intervient pour la quatrième fois ».

GPT écrit la bonne question, et elle vaut d'être retenue comme méthode :

> Lorsqu'un même commentaire revient quatre fois, la question n'est pas
> « puis-je supprimer trois paragraphes ? » mais **« quel objet formel aurait
> permis de ne jamais les écrire ? »**

**Instruction.** Pour chaque annonce de répétition, supprimer l'annonce et citer
l'objet du lot B. Les cinq objets couvrent tous les cas relevés :

| Annonce | Objet qui la rend inutile |
|---|---|
| « c'est la même loi » | compatibilité de l'action graduée *(I-07)* |
| « la même forme de commutation » | lemme-schéma de commutation *(I-08)* |
| « le même pontage » | schéma de préservation *(I-09)* |
| « ce n'est pas une primitive nouvelle » | théorème d'élaboration *(I-12)* |
| « la même figure qu'au chapitre 3 » | garantie par inexpressibilité *(I-13)* |

**C'est pourquoi le lot B doit précéder le lot D.** Supprimer les annonces avant
d'avoir écrit les objets laisserait le lecteur sans la loi qui unifie.

---

# L'ordre d'exécution

| Lot | Contenu | Pourquoi à ce rang |
|---|---|---|
| **A** | I-01 à I-06 | corrigent ce qui est faux ; rien ne doit passer avant |
| **B** | I-07 à I-13 | écrivent les objets ; le lot D en dépend |
| **C** | I-14 à I-20 | distillent ; indépendants entre eux |
| **D** | I-21 à I-28 | normalisent ; **I-28 en dernier**, il consomme le lot B |

**Deux dépendances strictes.** I-04 avant I-10. Le lot B avant I-28.

**Une instruction dont l'issue n'est pas acquise :** I-04. Toutes les autres sont
des réécritures dont le résultat est connu d'avance.

---

# Les six contrôles à écrire

Ils empêchent la régression, et cinq sont mécaniques.

| | Contrôle | Instruction gardée |
|---|---|---|
| 1 | `\Gamma \vdash` interdit hors du chapitre 2 | I-22 |
| 2 | `□` sans indice t interdit hors de la confidentialité | I-21 |
| 3 | « sans collision », « injectif », « unique » interdits près d'un hachage | I-05 |
| 4 | « conaturel » et « ℚ≥0 » jamais à moins de 300 signes | I-02 |
| 5 | tout symbole du corps figure à la table normative | I-26 |
| 6 | tout énoncé porte l'un des sept mots de statut | I-27 |

Le septième — « ce mot désigne-t-il le bon objet mathématique ? » — n'est pas
mécanisable, et c'est celui qui a trouvé I-01. Il demandera une relecture
externe à chaque version majeure.
