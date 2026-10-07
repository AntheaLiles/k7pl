# Registre empirique — les entrées G

## Ce que ce registre contient

Les entrées de *travail empirique* : ce qui ne se démontre pas et ne se raisonne pas, mais se mesure. Trois d'entre elles n'attendent aucun prototype et pouvaient donc être tranchées ; les neuf autres attendent un noyau exécutable et sortent du manuscrit par nature.

## \[DONE\] G-01 — Le coût d'expressivité de P3 et P4

    ENGAGEMENT: table 1, ligne 6 | ATTEND: le noyau exécutable de la phase 1

**La question.** Les deux postulats excluent des programmes — P3 ceux dont la terminaison n'est pas structurellement évidente, P4 les ordonnancements non déterministes que certains systèmes sensibles à la latence préfèrent. Que perd-on réellement, et le gain en garanties le compense-t-il ?

**Ce qui est rendu, le 9 septembre.** Le protocole de mesure est *écrit au manuscrit* (chapitre 1) plutôt que laissé à imaginer : un corpus de programmes témoins, le relevé de ceux que les deux postulats rejettent, et pour chacun la recherche d'une reformulation acceptée. Ce qui en sort est un taux de rejet sans reformulation disponible, et non une opinion.

L'engagement de la table 1 cesse de se lire « un pari, sans mesure » pour se lire « un pari dont le protocole de mesure est écrit et non conduit ». La différence tient à ce qu'un pair peut désormais le contredire.

**Ce qui reste.** Conduire la mesure, quand le noyau exécutera.

## \[DONE\] G-05 — Le coût d'expressivité de la délimitation

    ENGAGEMENT: table 1, ligne 8 | ATTEND: rien — mesurable dès le gel de la syntaxe

**La question.** Un délimiteur ne s'écrit qu'au point où le fragment change. Si ces points sont rares, le coût est nul ; s'ils sont fréquents, le langage devient verbeux là où il prétend être net. Personne n'avait compté.

**Ce qui rend la question sérieuse.** Le manuscrit porte en regard un essai contrôlé randomisé sur la propriété, les actifs et le typestate — le jeu de traits même de ce langage — qui trouve la condition à types avancés plus lente et à variance élevée. Le chapitre 5 écrit lui-même que c'est « le risque principal du dispositif ».

**Ce qui est rendu.** Le protocole est écrit, et il ne demande rien d'exécuter : la mesure se fait *sur du texte* — un corpus représentatif, le comptage des franchissements de fragment par millier de lignes, rapporté au nombre d'expressions. Elle est disponible dès que la syntaxe est gelée.

**Ce qui reste.** Compter. C'est la seule des trois mesures qui n'attend rien, et elle porte sur le risque que le document désigne comme principal : elle passe donc en tête.

## \[DONE\] G-06 — Le modèle matériel de référence

    POINT-DE-CONTROLE: chapitre 4, modèle mémoire | ATTEND: rien pour la requalification ; du matériel pour la mesure

**La question.** Le langage sélectionne le modèle acquisition-libération sans nommer la machine contre laquelle ses bornes valent. Or une borne de temps d'exécution au pire cas n'a pas de sens absolu : elle vaut d'un profil matériel.

**Ce que la recherche avait rendu.** QF-20 a instruit le protocole et rapporte un avertissement plus utile que le protocole : les observations qui comptent dans un test de cohérence mémoire sont extrêmement rares et de nature probabiliste. Sans protocole réglé, l'absence d'observation ne distingue pas l'impossibilité de l'improbabilité — et le point de contrôle donne alors une confiance *illusoire* plutôt que faible.

**Ce qui est rendu.** La borne est *requalifiée comme relative à un profil*, au chapitre 4 et à l'endroit où le modèle est choisi. Le document ne pose pas de profil et n'en a pas besoin, n'ayant chiffré aucune borne ; il écrit que toute borne chiffrée qu'il porterait un jour devrait nommer son profil.

Le choix se convertit sans rien défaire : le jour où une borne sera chiffrée, il faudra poser le profil et le protocole de réglage, et la phrase écrite aujourd'hui sera exactement l'endroit où les inscrire.

## \[TODO\] Les neuf entrées qui attendent un prototype

Elles sortent du manuscrit par nature : aucune ne se tranche par la lecture ni par la démonstration, et aucune n'est attendue par un énoncé du document.

- **G-02** — la mesure du coût d'exécution des garanties, une fois l'effacement effectif.
- **G-07** — les deux axes de l'agenda de mise à l'épreuve, coût d'expressivité et garanties tenues, dont G-01 et G-05 sont les deux instances instruites.
- **G-08 à G-12** — l'agenda de mise à l'épreuve proprement dit : charge d'annotation, courbe d'apprentissage, qualité des diagnostics, temps de compilation, comparaison à un langage témoin.

## Ce que ce registre a appris

Trois décisions ont attendu parce qu'elles étaient *nommées sans être définies*. Le tableau de `plan.org` les assignait, et il n'y avait rien derrière le nom.

La règle qui s'en déduit vaut au-delà de ce registre : **une entrée assignée doit pointer vers un texte qui dit ce qu'elle est**. Un identifiant n'est pas une instruction, et un tableau qui renvoie au vide fait perdre plus de temps qu'il n'en fait gagner.
