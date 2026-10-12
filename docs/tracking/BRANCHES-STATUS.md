# Statut des branches de travail

**Audit API : 2026-10-11, 13:20 Europe/Paris.**  
**État observé :** 33 références de branche, dont `main`, et cinq PR ouvertes.

Cet inventaire distingue les branches qui portent une PR ouverte, les archives scientifiques à conserver et les branches anciennes/supersédées. Il ne donne pas autorisation de fusion ni de suppression. Les rebase/squash et les changements d'historique rendent les nombres de commits en avance/retard impropres à établir seuls qu'une branche contient ou non du matériau unique.

## Référence canonique et PR ouvertes

| Branche | Statut au moment de l'audit | PR | Action |
|---|---|---|---|
| `main` | référence canonique, protégée | — | Seule référence normative courante. SHA observé : `5655628693eb86eca8f8bef026a1d1f384264a71`. |
| `research/stage-c-interface-closure` | active, brouillon de suivi C | [#154](https://github.com/AntheaLiles/k7pl/pull/154) | Porte C toujours ouverte ; vérifier le nouveau CI après mise à jour des documents. |
| `automation/generated-status` | PR automatisée ouverte | [#148](https://github.com/AntheaLiles/k7pl/pull/148) | `docs/STATUS.md` est généré. Ne pas le modifier manuellement. |
| `docs/semantic-migration-closeout-2026-10-11` | active, brouillon | [#153](https://github.com/AntheaLiles/k7pl/pull/153) | Rebaser/réconcilier les changements contre `main` ; examiner également les changements de `spec/` et de l'outillage. |
| `feat/c8-controlled-statement-migration` | active | [#139](https://github.com/AntheaLiles/k7pl/pull/139) | Examiner la migration contrôlée des 69 blocs historiques et des cinq objets compagnons ; CI verte ne vaut pas validation mathématique. |
| `research/lean-assurance-evaluation-2026-10-11` | active, brouillon | [#151](https://github.com/AntheaLiles/k7pl/pull/151) | Chantier K indépendant de C ; vérifier la réconciliation du plan maître avant fusion. |

L'état des PR doit être reconsulté avant toute action : ce tableau est une photographie datée, pas un substitut à l'API GitHub.

## Branches à conserver pour revue scientifique

| Branche | Traitement | Motif |
|---|---|---|
| `claude/lean4-reuse-init-qvzlcg` | **Archive scientifique non normative ; conserver** | Contient des journaux et analyses PR-02 uniques, absents de `main`. Aucune conclusion de cette branche n'est ratifiée par sa seule existence. |
| `repair/pr54-coherence-2026-10-08` | **Archive de travail à réconcilier ; conserver** | Contient une importante trajectoire ancienne autour de la reprise C. Ne pas fusionner en bloc ; rapprocher les notes et conclusions de la matrice C-01–C-09 actuelle. |
| `split/pr10-3-singularites` | Référence historique uniquement | Ne constitue pas une résolution courante de BLOQ-12. Toute proposition doit être requalifiée après satisfaction du verrou C. |

## Branches avec PR fusionnée ou travail intégré

Ces branches ne doivent pas servir de point de départ à de nouvelles modifications. Leur conservation ou suppression dépend d'une comparaison de contenu, pas uniquement de l'ascendance Git.

| Branche | Trace principale | Traitement |
|---|---|---|
| `docs/semantic-navigation-model` | PR #137 fusionnée | Provenance historique ; ne pas redévelopper le modèle depuis cette tête. |
| `feat/figure-provenance-navigation` | PR #136 fusionnée | Le catalogue de provenance est intégré à `main`. |
| `feat/semantic-navigation-graph` | PR #138 fusionnée | Graphe sémantique initial intégré. |
| `feat/semantic-navigation-rendered-links` | PR #141 fusionnée | Liens vers les pages rendues intégrés. |
| `feat/semantic-navigation-multi-slice` | PR #144 fusionnée | Deuxième tranche intégrée. |
| `feat/tikz-figure-poc` | PR #127 fusionnée | POC historique ; la génération de figures a été intégrée ensuite. |
| `feat/tikz-production-artifacts` | PR #135 fusionnée | Production d'artefacts intégrée. |
| `feat/tikz-production-integration` | PR #133 fusionnée | Intégration au build principal. |
| `fix/semantic-graph-auto-width` | PR #146 fusionnée | Correction intégrée. |
| `fix/tikz-visual-fidelity` | PR #142 fusionnée | Correction intégrée. |
| `fix/verso-figure-assets-html` | PR #124 fusionnée | Correction HTML intégrée. |

## Branches supersédées ou historiques

| Branche | État connu | Règle de reprise |
|---|---|---|
| `feat/c8-controlled-statement-migration-ci` | PR #143 fermée sans fusion, supersédée par #139 | Ne pas reprendre séparément ; le correctif de migration doit rester sur #139. |
| `feat/c8-shared-statement-ontology` | PR #130 supersédée par #131 | Ne pas fusionner ; la version intégrée est la référence. |
| `feat/c8-statement-dependency-check` | PR #85 supersédée par le travail intégré sur `main` | Historique ; ne pas réactiver sans défaut concret. |
| `feat/c8-dependency-cycle-audit` | PR #87 supersédée par le travail intégré sur `main` | Historique ; ne pas réactiver sans défaut concret. |
| `feat/lake-osv-scanning` | PR #103 supersédée par #104 | Ancienne tentative ; ne pas fusionner. |
| `feat/tikz-production-figures` | PR #132 fermée sans fusion, supersédée par #133/#135 | Ancienne trajectoire ; ne pas fusionner. |
| `feat/navigation-graph-mvp` | Pas de PR ouverte associée au snapshot | Comparer son contenu aux PR intégrées avant toute réutilisation ou suppression. |
| `ci/diagnostic-localization` | PR #65 fermée sans fusion ; approche ultérieure intégrée via #66 | Ne pas réouvrir telle quelle ; contrôler tout élément distinctif avant suppression. |
| `improvement-suggestions-c74e0` | Ancienne PR #27 fermée sans fusion | Ancienne branche très divergente ; ne pas fusionner en bloc. Examiner seulement une proposition précise si elle reste pertinente. |
| `split/pr10-1-outillage-spec` | Abandonnée explicitement ; remplacée par `tools/SpecExt/IndexTerms.lean` | Ne pas reprendre `{printindex}` depuis cette branche. |
| `split/pr10-2-troncature-conformite` | Matériau historique associé à la PR #33 intégrée | Ne pas fusionner en bloc. |
| `split/pr10-4-manuscrit-semantique` | Branche cumulative historique de PR-10 | Ne pas fusionner ; les tranches ont été séparées, revues et intégrées autrement. |
| `tooling/prototypes-bcd` | Ancienne trajectoire des annexes B/C/D | Historique ; ne pas la confondre avec une décision actuelle sur ces annexes. |

## Politique de nettoyage

1. Aucun nettoyage massif n'est autorisé par cet inventaire.
2. Pour chaque branche sans PR ouverte, vérifier le commit exact, les fichiers qui diffèrent de `main`, les PR historiques correspondantes et la présence éventuelle de notes scientifiques uniques.
3. Les branches dont le contenu a été fusionné ou explicitement supersédé peuvent être proposées à la suppression une fois cette vérification enregistrée.
4. Les branches `claude/lean4-reuse-init-qvzlcg` et `repair/pr54-coherence-2026-10-08` restent conservées jusqu'à une revue scientifique explicite.
5. Les branches de migration cumulative ne remplacent jamais les portes de sortie. En particulier, `split/pr10-3-singularites` ne permet pas de contourner l'étape C.
6. Ce document a été mis à jour dans la PR de reprise C ; la PR #153 portait aussi une modification antérieure de ce fichier. Avant de fusionner les PR de suivi, réconcilier leur version de `BRANCHES-STATUS.md` afin de ne pas réintroduire l'ancien décompte.
