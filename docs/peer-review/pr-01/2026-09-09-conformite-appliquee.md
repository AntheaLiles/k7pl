# Mise en conformité — journal d'exécution

9 septembre 2026. Les vingt-huit instructions ont été appliquées au manuscrit,
lot par lot, avec reconstruction et contrôle après chaque lot.

**État final : 3 ECHEC**, les mêmes qu'au départ — les trois de ν, que la
décision B refermera. Aucune régression introduite.

---

## Ce qui a changé au manuscrit

### Lot A — les six corrections de fond

| | Où | Ce qui a été écrit |
|---|---|---|
| **I-01** | c2 §2.2 | La famille graduée devient une **structure de Kleisli graduée** \(\mathbf{Kl}_\mathcal{R}\), avec \(\mathrm{Hom}^r(A,B)\). Le texte dit maintenant pourquoi ce n'est pas une catégorie — composition non interne, identité au seul grade neutre — et nomme les **deux grades qui en portent une**, le neutre et l'absorbant. Trois autres emplois du mot corrigés en aval. |
| **I-02** | c2 §2.2 et §2.3 | « sur le fragment entier » devenait « restreint au sous-semi-anneau des entiers » — l'ambiguïté du français était le vrai défaut. Ajout de la **clause de bonne formation** : tout indice de taille est pris dans \(\mathbb{N}_\infty \setminus \{\omega\}\), avec l'argument en une ligne (un ordre strict bien fondé est irréflexif). |
| **I-03** | c4, et P4 en c1 | Le théorème 17 scindé en **déterminisme logique** (\(\approx_{\text{obs}}\)) et **identité binaire sous \(E_{\text{repro}}\)**. P4 réécrit : le rejeu est logique par construction, binaire sous hypothèse. |
| **I-04** | c3 | La **simulation du graphe d'attente** est nommée dans la preuve : `wait(a,b) ⟹ dep(a,b)`. Voir la réserve ci-dessous. |
| **I-05** | c4 et c6 | « sans collision » → « résistant aux collisions » ; O(1) réservé à la comparaison, O(n) au calcul ; l'hypothèse cryptographique déclarée comme telle. Au chapitre 6, « sémantiquement équivalents » → « dont les arbres coïncident après normalisation », avec la précision que l'équivalence sémantique n'est pas décidable. |
| **I-06** | c1, P1 | P1 n'exige plus l'inversibilité : toute optimisation porte un **morphisme de correction sémantique**, et l'isomorphisme n'en est que le cas facile. La défonctionnalisation y est nommée comme le cas où il n'est pas inversible. |

### Lot B — les sept objets formels

**C'est la partie qui distille.** Une nouvelle section, `c2 §2.6 Trois schémas de
métathéorie`, porte quatre théorèmes ; deux autres sont posés ailleurs.

| | Objet | Instances rattachées |
|---|---|---|
| **I-07** | **Compatibilité de l'action graduée** — le théorème 33 remonté de l'annexe au chapitre 2 | Les **quatre annonces de comptage supprimées** : « pour la deuxième fois », « une troisième fois », « pour la quatrième fois », « la forme se rencontre pour la troisième fois ». Chacune devient une citation du théorème. |
| **I-08** | **Schéma de commutation** — \(T \circ \text{subst} = \text{subst} \circ T\) | `thm:hygiene` (c5) et `thm:commutation_traduction` (annexe) |
| **I-09** | **Schéma de préservation par traduction** — si l'image de chaque règle est une dérivation, le jugement est préservé | `thm:abaissement_grades` (c6) |
| **I-10** | **Tri topologique** | `thm:deadlock_acyclique` (c3) et `thm:liberte_initialisation` (c4) |
| **I-11** | **Lemme de capacité** | `thm:surete_spatiale` (c4) |
| **I-12** | **Théorème d'élaboration** — `Elab(s) = t ∧ Δ ⊢ t : A | ℰ ⟹ Sens(s) = Sens(t)` | Nouvelle section `c5 §5.3`. La staticité de la syntaxe et la dérivabilité de l'expansion en deviennent des corollaires. **Les six formes de surface passent en un tableau de six lignes.** |
| **I-13** | **Garantie par inexpressibilité** — définie au chapitre 1, à côté de la condition de clôture | Trois redéveloppements réduits à des renvois (c4, c5 deux fois) |

### Lot C — distiller

| | Ce qui a été fait |
|---|---|
| **I-14** | \(\mathcal{T}_{\text{K7PL}}\) et \(\mathcal{T}_0\) nommés ; les obligations hors fragment sont **rejetées** et jamais soumises. La borne de la Phase 5 vaut désormais du fragment déclaré. |
| **I-15** | La frontière des effets indexés porte sur le **moment** et non le degré : indice clos à la compilation contre indice dépendant d'une valeur d'exécution. K7PL a donc des effets indexés, sous leur forme statique. |
| **I-16** | La fausse piste supprimée de l'annexe : la forme des opérations à portée n'est plus dite « non fixée » alors que la même annexe la fixe trente pages plus loin. Étiquette `sec:g-scoped` posée. |
| **I-17** | Les cinq mots-clés passent d'un paragraphe dense à un **tableau de cinq lignes** — mot-clé, obligation projetée, lieu où elle est déjà vérifiée. |
| **I-19** | **Théorème de stabilisation du pipeline** écrit : la boucle vérification–optimisation termine sous un budget de spécialisation fini. Le manuscrit avait le budget et la mesure ; il lui manquait l'énoncé. |
| **I-20** | Les tests : « est » devient **« couvre »**, et le revers est écrit — le test de propriétés reste nécessaire, l'oracle demeure une hypothèse de confiance. |

### Lot D — normaliser

| | Ce qui a été fait |
|---|---|
| **I-21** | **18 occurrences** de \(\Box_r\) unifiées vers \(!_r\), dans trois fichiers. Le carré est libéré pour le temps. Vérifié : aucun carré temporel ne portait d'indice, la substitution était donc sûre. |
| **I-22** | Les trois `\Gamma \vdash` traités : deux corrigés en \(\Delta\) — gradualité statique et préservation du type —, le troisième conservé avec une incise disant que c'est l'objet catégorique. Les contextes de la sûreté spatiale passent aussi en \(\Delta\). |
| **I-23** | L'ensemble d'échappatoires devient \(\mathcal{X}\), qui ne se confond plus avec \(\mathcal{E}\). |
| **I-24** | « trois modes reliés par une chaîne » devient « la construction en engendre quatre ; K7PL en instancie trois, dont l'ordre est le fragment totalement ordonné du treillis ». |
| **I-26** | **Table normative des symboles** écrite au chapitre 1, avec le paragraphe qui justifie l'arbitrage entre les deux relectures. |
| **I-27** | La nomenclature passe de quatre à **sept mots** : réserve, obligation et exigence reçoivent leur définition d'une ligne. |
| **I-28** | Consommé par le lot B — chaque annonce de répétition a été remplacée par la citation de l'objet qui la rend inutile. |

---

## Les cinq contrôles écrits

Nouveau module `outils/controles/notation.py`, branché à `controle.py`. **Les
cinq passent.**

| | Contrôle | Ce qu'il ferme |
|---|---|---|
| 1 | `contexte_du_jugement` | `\Gamma \vdash` hors du chapitre 2 |
| 2 | `un_glyphe_par_modalite` | tout carré indicé — la ressource s'écrit `!_r` |
| 3 | `affirmations_sur_le_hachage` | « sans collision », « injectif » à moins de 200 signes d'un hachage |
| 4 | `grades_et_tailles_distingues` | ℛ identifié aux conaturels sans restriction déclarée |
| 5 | `symboles_a_la_table_normative` | la table existe et couvre les symboles gouvernés |

Le sixième — « ce mot désigne-t-il le bon objet ? » — n'est pas mécanisable. Il
a trouvé I-01, et il demandera une relecture externe à chaque version majeure.

---

## Trois choses que je dois te signaler

### 1. Une citation que je n'ai pas écrite

La clause de bonne formation sur les tailles s'appuie sur un fait de la
littérature — une plus grande taille réflexive rend le système inconsistant.
**La clé n'existe pas au fonds**, et je n'invente pas de citation. J'ai donc
écrit l'argument interne, qui se suffit : un ordre strict bien fondé est
irréflexif.

Deux sources à verser si tu veux l'appuyer : le ticket Agda #1946, et
*Constructing (Co)inductive Types via Large Sizes*. C'est à toi de les ajouter,
je n'écris pas dans la bibliographie.

### 2. GPT avait tort sur le graphe d'attente, et le manuscrit était meilleur

Sa section 6 réclame une distinction que le chapitre 3 **fait déjà**, et mieux
qu'il ne la formule :

> « Deux graphes sont en jeu, et les confondre serait l'erreur à ne pas
> commettre. […] L'acyclicité du premier n'implique donc pas mécaniquement
> celle du second. »

Le vrai manque était plus fin : la coinduction avait son **amorce** et pas son
**étape de préservation**. Je l'ai nommée plutôt que de la démontrer, parce
qu'elle demande d'établir un fait sur le langage. Le texte porte déjà « s'il
tient / s'il tombe », donc le statut conditionnel est honnête. **C'est la seule
instruction dont l'issue reste ouverte.**

### 3. Ce que je n'ai pas fait

- **I-18**, les trois préservations nommées séparément, demande d'écrire une
  préservation par effacement qui n'existe pas encore. C'est du travail de
  fond, pas de conformité.
- **I-25**, séparer ⊑ et ⊑\_<: par deux glyphes, touche la table du produit
  mixte et son remontage au chapitre 2. À faire quand tu voudras déplacer la
  table.
- La **table de correspondance numéros/étiquettes** reste à verser à `meta/` :
  la prochaine relecture externe partira du même document imprimé, et sans elle
  aucune de ses recommandations n'est applicable.
