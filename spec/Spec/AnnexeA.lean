-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.AnnexeA.FrontieresDeCouchesEtDisciplineDe
import Spec.AnnexeA.PureteEtDisciplineDeLaCouche3
import Spec.AnnexeA.TerminaisonEtProductivite
import Spec.AnnexeA.CapabilitesEtMemoire
import Spec.AnnexeA.ProtocolesSessionsEtTopologieDistribuee
import Spec.AnnexeA.DistinctionDePhaseEtMetaprogrammation
import Spec.AnnexeA.ContraintesDeValeurEtPreuvesResiduelles

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "A. CODES D'ERREUR" =>
%%%
file := "annexe-errors"
tag := "annexe-errors"
number := false
%%%

{refsection "k7-errors"}

{label "sec:annexe-a-codes" (display := "A")}

Le corpus source range ces codes par ordre alphabétique de préfixe. Cette annexe les regroupe par
l'invariant qu'ils protègent, afin qu'un lecteur cherchant pourquoi un programme est rejeté trouve
le chapitre correspondant plutôt qu'une liste sans principe. Deux écarts avec le corpus source sont
assumés. `ERR-TOP-003`, mentionné au chapitre 6 (§{num "sec:c6-le-processus-de-compilation"}[]) mais
absent de la table source, est ajouté ici. `ERR-FFI-001` et `ERR-TYP-008`, qui y désignent tous deux
une fuite de descripteur à travers la passerelle FFI, sont réunis sur une seule ligne. Cette table
reste illustrative et non exhaustive : tout mécanisme nouveau engendrerait des codes qu'elle ne peut
anticiper, et le regroupement thématique facilite la navigation sans garantir la complétude —
qu'aucune partie de ce document n'a revendiquée pour cette annexe.

:::comment
```
À explorer pour un futur état de l'art de cette annexe : conventions de diagnostics riches dans les compilateurs contemporains (Rust, Elm, Roc) ; travaux sur le message d'erreur de type comme objet de recherche à part entière (Wand ; Heeren, Hage et Swierstra).
```
:::

Un code ne vaut que par le message qu'il porte, et il faut dire sur quoi cette annexe s'appuie pour
en régler la forme — car ce qu'on peut invoquer ici est plus mince qu'il n'y paraît. Une revue
systématique d'un demi-siècle de littérature sur les messages d'erreur retourne six cent cinquante
et un articles, en inspecte quatre cent quarante-huit à la main, et en tire dix lignes directrices
qui englobent vingt des vingt-deux propositions des quatre travaux ayant tenté une synthèse. Son
verdict sur la qualité de la preuve est sévère. La plupart de ces suggestions, en particulier celles
des quatre décennies qui suivent 1960, reposent sur des anecdotes ou l'opinion d'experts. Et la
_lisibilité_, première des dix lignes directrices, est posée comme critère depuis cinquante ans par
une source fondatrice qui ne fournit aucun mécanisme pour l'évaluer {cite "beckerCompilerErrorMessages2019"}[].
Ce document peut donc invoquer une convergence d'opinion experte sur la forme de ses messages ; il
ne peut pas invoquer un effet mesuré, et la différence décide de ce qu'un relecteur peut lui
opposer.

Deux résultats échappent à cette réserve, parce qu'ils sont mesurés. Le premier chiffre ce que la
lisibilité d'un message coûte en temps : sept cent dix virgule sept secondes contre trois cent
vingt-quatre virgule neuf, soit un facteur deux, à moins d'un pour mille {cite "dennyErrorMessageReadability2020"}[].
Le second isole les facteurs qui la déterminent — longueur du message, emploi de jargon, structure
de la phrase, vocabulaire — par trois expériences dont la troisième fait noter des messages par des
débutants sur des échelles dérivées des deux premières {cite "dennyDesigningProgrammingError2021"}[].
Ces quatre facteurs sont les seuls dont cette annexe se réclame, et ils gouvernent la colonne «
déclencheur et correction » de chacune des tables qui suivent : un déclencheur nommé sans jargon,
une correction dite en une phrase, et rien qui suppose un serveur de langage à portée.

Une distinction de plus est employée ici, et elle vient d'ailleurs, ce qu'il faut déclarer. Les
messages de ce langage se répartissent en trois niveaux — le _signal_, qui dit ce qui est faux à un
endroit ; la _règle_, qui dit quel invariant a été violé ; la _connaissance_, qui dit pourquoi cet
invariant existe. Cette stratification n'est pas une invention de la littérature des messages
d'erreur : c'est la taxonomie des niveaux de contrôle cognitif d'un opérateur {cite "rasmussenSkillsRulesKnowledge1983"}[],
et aucune des dix lignes directrices de la revue ne la nomme. L'appliquer aux diagnostics d'un
compilateur est donc un transport, et il se justifie par ceci que la taxonomie porte sur ce qu'un
opérateur fait d'une information — ce qu'un message d'erreur est. Le transport est faisable ; il
n'est pas acquis, et la question de savoir à quel niveau un message doit s'adresser dépend de ce que
le lecteur sait déjà, ce qu'aucune mesure du corpus ne tranche.

{include 0 Spec.AnnexeA.FrontieresDeCouchesEtDisciplineDe}

{include 0 Spec.AnnexeA.PureteEtDisciplineDeLaCouche3}

{include 0 Spec.AnnexeA.TerminaisonEtProductivite}

{include 0 Spec.AnnexeA.CapabilitesEtMemoire}

{include 0 Spec.AnnexeA.ProtocolesSessionsEtTopologieDistribuee}

{include 0 Spec.AnnexeA.DistinctionDePhaseEtMetaprogrammation}

{include 0 Spec.AnnexeA.ContraintesDeValeurEtPreuvesResiduelles}
