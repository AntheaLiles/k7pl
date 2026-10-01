-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "B. SPECIFICATION LSP {amp}[] REPL" =>
%%%
file := "annexe-lsp-repl"
tag := "annexe-lsp-repl"
number := false
%%%

{refsection "k7-lsp-repl"}

{label "sec:annexe-d-interface" (display := "B")}

Le protocole LSP et le REPL ne sont pas deux outils ajoutés à K7PL après coup : ce sont le système
déjà construit, rendu visible en temps réel plutôt qu'à la seule compilation. Cette annexe en
esquisse une première spécification, entièrement dérivée des mécanismes établis.

Le serveur LSP expose quatre services, chacun une lecture directe d'un mécanisme des chapitres
précédents. La complétion propose, pour un trou `_` laissé dans le texte, les termes que le
narrowing (chapitre 3, §{num "sec:c3-structures-ouvertes-effets-et"}[]) accepte à cette position —
le trou étant le point le moins précis du treillis $`\sqsubseteq` pour le type attendu, la
complétion n'est que la recherche, dans ce même treillis, des raffinements qui satisfont la
contrainte. Sur un raffinement laissé en trou, le compilateur ne remplace jamais silencieusement le
trou : il calcule les bornes nécessaires à la sûreté mémoire et retourne un diagnostic proposant
`(and (>= 0) (< length))`, que le développeur doit recopier lui-même dans le texte source, pour que
la contrainte reste auditable plutôt qu'implicite. Le diagnostic accompagne un rejet de la tranche
minimale de dérivation (chapitre 3, §{num "sec:c3-structures-ouvertes-effets-et"}[]) qui l'explique,
plutôt que du seul message d'erreur.

La visualisation traduit une machine à états composable (chapitre 4,
§{num "sec:c4-echelle-du-systeme"}[]) en diagramme, puisque sa description est déjà celle d'un
graphe. Le refactoring, enfin, n'autorise un remplacement de fragment de programme que lorsque la
relation de substituabilité généralisée du chapitre 3
(§{num "sec:c3-structures-ouvertes-effets-et"}[]) — préconditions affaiblies, postconditions
renforcées — est vérifiée entre l'ancien et le nouveau fragment, jamais sur la seule ressemblance
syntaxique.

::::listing (label := "lst:trou-raffinement")
:::caption
Un raffinement laissé en trou, que la complétion résout par narrowing
:::

```
{deftype safe-index Int64
  "Index sécurisé."
  :where _}
```
::::

::::figure (label := "fig:services-lsp") (src := "services-lsp") (alt := "Les quatre services du LSP, chacun ancré dans un mécanisme déjà construit") (width := "90")
:::caption
Les quatre services du LSP, chacun ancré dans un mécanisme déjà construit
:::

:::desc
Les quatre services et le mécanisme du manuscrit dont chacun n'est qu'une lecture.
:::
::::

Le REPL est le mode d'évaluation interactif de K7PL. Chaque expression y est compilée par le mode
JIT (chapitre 6, §{num "sec:c6-le-processus-de-compilation"}[]), seul contexte où ce mode est
autorisé. Son résultat s'affiche sous forme tabulaire plutôt que comme une valeur imprimée,
conformément à l'ontologie du chapitre 2 selon laquelle un tableau n'est jamais qu'une fonction
depuis un type fini. Le prompt suit le format `utilisateur@domaine[cible][branche]: λ expr`, où
`cible` et `branche` situent la session dans la topologie d'acteurs (chapitre 4,
§{num "sec:c4-echelle-du-systeme"}[]) sur laquelle elle opère.

Le Replay Debugger prolonge ce même REPL vers le passé d'une exécution plutôt que vers son futur. Il
charge le journal Cap'n Proto d'un acteur (chapitre 4, §{num "sec:c4-echelle-du-systeme"}[]) et
rejoue la séquence de messages à travers ses gestionnaires purs, la pureté garantissant que ce rejeu
reproduit fidèlement l'original. Les commandes `play`, `pause`, `stop`, `next`, `previous` et les
deux défilements rapides — avant, arrière — parcourent cette séquence exactement comme un lecteur
multimédia parcourt un flux enregistré, sans qu'aucune instrumentation n'ait dû être ajoutée après
coup au programme observé.

:::comment
```
À explorer pour un futur état de l'art de cette annexe : spécification du Language Server Protocol ; environnements de preuve interactifs à trous typés (Agda, Idris, Hazel — Omar et al.) ; débogueurs à rejeu déterministe (rr, Pernosco) ; notebooks de calcul interactif (Jupyter) pour comparaison avec le REPL tabulaire.
```
:::
