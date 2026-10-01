# Doctrine E — la route de chaque engagement

9 septembre 2026. Formalisée au chapitre 1, portée par une colonne de la table,
et gardée par un contrôle.

---

## La règle

> **Tout engagement de ce document nomme la route par laquelle il se lèvera, et
> il n'y en a que trois.**

| Route | Quand | Ce que l'engagement porte alors |
|---|---|---|
| **littérature** | l'énoncé est déjà établi ailleurs | sa source primaire, référencée et non redémontrée |
| **démonstration** | il ne l'est pas | le nom du théorème qui l'acquittera |
| **mesure** | il ne se démontre pas du tout — c'est un énoncé sur l'usage ou sur une réalisation | le protocole qui le trancherait |

Un engagement sans route nommée n'est pas un engagement, c'est un aveu. Une
quatrième route serait une manière de ne pas choisir.

---

## Les huit, classés

| Engagement | Route | État |
|---|---|---|
| Cohérence au sens de Kelly et Mac Lane | littérature | **tenu** — référencé dans sa source primaire |
| Enrichissement sur les préordres, part excédant l'ordre des fibres | démonstration | **ouvert** — le théorème de raffinement en dérive l'autre part, rien n'établit celle-là |
| Isolation par types plutôt que par unité de gestion mémoire | mesure | ouvert — une réalisation déployée, pas une preuve |
| Conformité de l'abaissement au modèle mémoire déclaré | démonstration | ouvert — propriété du compilateur, à mécaniser |
| Fidélité de l'interpréteur de référence | démonstration | **LEVÉ** |
| Coût d'expressivité de P3 et P4 | mesure | protocole écrit, non conduit |
| Reproductibilité de la compilation | mesure | visée, non garantie, et le document l'écrit |
| Rareté des changements de fragment | mesure | protocole écrit, mesurable dès le gel de la syntaxe |

---

## Ce que la doctrine a trouvé en s'appliquant

**La table s'accusait d'une dette qu'elle avait payée.**

Elle portait, pour la fidélité de l'interpréteur de référence : « une voie
désignée, non parcourue ». Or l'annexe écrit, à la fin de sa section sur la
traduction :

> « *Le théorème `thm:traduction_metalangage` est donc démontré*, et la dette de
> fidélité que le chapitre 6 nommait — établir que ⟦·⟧ préserve le typage — est
> acquittée. »

La démonstration existait et la table l'ignorait. **Un document qui ne relit pas
ses engagements finit par s'accuser de dettes qu'il a réglées** — et un pair qui
tente de reproduire aurait cherché une preuve absente qui était là.

C'est la première conséquence de la doctrine, et elle a joué le jour où on l'a
posée : *un engagement dont la route est la démonstration cesse d'être un
engagement le jour où le théorème est écrit.* Encore faut-il aller le vérifier.

---

## Les deux autres conséquences

**Un engagement dont la route est la mesure ne se lèvera jamais par la
lecture.** Il est vain de l'y attendre, et vain de le relire en espérant qu'il
change. Trois des huit sont dans ce cas — l'isolation par types, la
reproductibilité, et les deux paris devenus protocoles.

**Un engagement sans route nommée est une anomalie**, et il en restait un : la
part de l'enrichissement qui excède l'ordre des fibres. Sa route est la
démonstration, et elle est maintenant écrite comme telle. C'est le seul de la
table qui soit ouvert *et* démontrable *et* sans théorème assigné — donc le
premier candidat au travail de fond.

---

## Le contrôle qui la garde

`route_de_chaque_engagement`, dans `outils/controles/notation.py`. Il vérifie
deux choses et refuse sur l'une ou l'autre :

- **chaque ligne porte une route** — un engagement ajouté sans route fait
  échouer la construction ;
- **aucune route hors des trois** — une quatrième valeur serait une manière de
  ne pas choisir, et elle est refusée.

Il passe. Trois routes distinctes, toutes admises.

---

## Ce que cela ouvre

Deux travaux se désignent d'eux-mêmes, et dans cet ordre.

1. **G-05** — compter les franchissements de fragment. C'est la seule mesure qui
   n'attend rien, et elle porte sur le risque que le chapitre 5 désigne comme
   principal.
2. **L'enrichissement, part hors fibres** — le seul engagement ouvert,
   démontrable et sans théorème assigné. Lui en assigner un est le travail de
   fond que la doctrine rend visible.
