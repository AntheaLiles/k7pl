# Statut des branches de travail

**Audit : 2026-10-08**

Cet inventaire remplace le cardinal historique de 18 branches figurant dans la revue de cohérence. Le dépôt expose actuellement 12 branches distantes ; les branches historiques qui ne sont plus présentes ne sont pas recréées.

| Branche | Statut | Décision |
|---|---|---|
| `main` | active | référence normative |
| `fix/coherence-generated-views` | active | branche de la PR #72 |
| `repair/pr54-coherence-2026-10-08` | active de travail | conserver tant que la trajectoire PR #54 n'est pas définitivement close |
| `automation/generated-status` | obsolète | PR #71 fermée, supersédée par #72 ; branche à supprimer lorsque l'opération de suppression sera disponible |
| `claude/lean4-reuse-init-qvzlcg` | archive scientifique | PR #10 fermée sans fusion ; conserve des journaux et analyses scientifiques uniques. Ne pas fusionner sans ratification scientifique. |
| `split/pr10-1-outillage-spec` | historique | travail d'index `{printindex}` abandonné ; remplacé par `tools/SpecExt/IndexTerms.lean` |
| `split/pr10-2-troncature-conformite` | historique | matériau de campagne PR-02, absorbé ou remplacé par les décisions ultérieures ; ne pas fusionner tel quel |
| `split/pr10-3-singularites` | historique | matériau de campagne PR-02, absorbé ou remplacé par les décisions ultérieures ; ne pas fusionner tel quel |
| `split/pr10-4-manuscrit-semantique` | historique | matériau de campagne PR-02, absorbé ou remplacé par les décisions ultérieures ; ne pas fusionner tel quel |
| `tooling/prototypes-bcd` | historique | PR #26 fusionnée sous une branche finale ; cette branche est un reliquat de travail |
| `ci/diagnostic-localization` | historique | PR #65 fermée sans fusion ; idée à reprendre seulement via une nouvelle PR explicitement cadrée |
| `improvement-suggestions-c74e0` | historique | PR #27 fermée sans fusion ; travail correspondant déjà intégré ou supersédé |

## Matériau scientifique non fusionné

La branche `claude/lean4-reuse-init-qvzlcg` contient notamment les journaux des séances PR-02 du 5 au 7 octobre 2026 et le corpus d’analyses de décisions de la branche. Une vérification contre `main` montre que plusieurs de ces documents ne sont pas présents dans l'arbre courant. Ils constituent donc bien du matériau scientifique unique.

Ce matériau est conservé comme **archive de travail non normative**. Son absence de fusion est volontaire et documentée : aucune conclusion scientifique, ratification, modification du manuscrit ou décision de vocabulaire contenue uniquement dans cette branche n'est réputée adoptée par `main`.

La branche `split/pr10-1-outillage-spec` a un statut différent : son travail `Index.lean` / `{printindex}` est explicitement abandonné et remplacé par `tools/SpecExt/IndexTerms.lean`, conformément à la décision déjà enregistrée dans `DECISIONS.md`.

## Règle de nettoyage

Une branche historique ne doit pas être réintroduite par fusion implicite. Lorsqu'une suppression de branche est possible, les branches marquées « historique » ou « obsolète » peuvent être supprimées après vérification qu'aucun PR ouvert ne les utilise. L'archive scientifique `claude/lean4-reuse-init-qvzlcg` doit rester conservée tant que son matériau n'a pas fait l'objet d'une décision scientifique séparée.
