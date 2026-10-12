<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Inventaire de l'enveloppe interactive K7PL

**État :** inventaire statique du dépôt au 12 octobre 2026 ; ne vaut ni validation d'usage, ni revue humaine, ni preuve de conformité PDF/UA.  
**Objet :** fermer le cadrage P0 de [l'enveloppe interactive](INTERACTIVE-EXPLORATION.md) sans ajouter une deuxième source de vérité.

## 1. Source canonique et outillage Verso

Le projet épingle Lean, Mathlib, CSLib et Verso sur la ligne de version `v4.34.0` dans [`lakefile.lean`](../../lakefile.lean). Le fichier [`spec/Spec.lean`](../../spec/Spec.lean) indique explicitement que les sources Verso sous `spec/` ont remplacé le manuscrit Org comme source de vérité à partir de leur introduction dans le dépôt. Il assemble le document (`#doc`, métadonnées, imports et `{include}` des chapitres) ; le rendu public est ensuite généré par la commande du projet `lake exe spec`.

K7PL emploie les mécanismes Verso suivants :

- les extensions Lean déclarées par `block_extension` et les commandes/rôles associés ;
- les passes `traverse`, qui enrichissent les blocs et enregistrent des informations de rendu, notamment dans l'état de traversal ;
- les rendus distincts `toHtml` et `toTeX`, avec les aides de [`SpecExt.Render`](../../tools/SpecExt/Render.lean) ;
- les blocs nommés et slots de [`SpecExt.Slots`](../../tools/SpecExt/Slots.lean), réutilisés notamment pour les énoncés, légendes, descriptions, notes et sources.

L'extension du site peut donc commencer par réutiliser les structures déjà traversées et les sorties déjà produites. Cela ne signifie pas que Verso fournit automatiquement un graphe sémantique complet : il faut encore définir et attester les relations qui ne sont pas explicitement présentes dans les sources.

## 2. Métadonnées Lean actuellement disponibles

| Élément | Modèle actuel | Portée et limite |
|---|---|---|
| Labels et références | [`SpecExt.Basic`](../../tools/SpecExt/Basic.lean), [`SpecExt.Label`](../../tools/SpecExt/Label.lean) : `LabelData` contient `kind`, `text`, `title` ; le domaine Verso relie les labels aux identifiants internes. | Utile pour l'identité et le rendu des renvois. Le numéro affiché est une donnée de présentation, pas un identifiant sémantique stable. |
| Énoncés | [`SpecExt.Theorem`](../../tools/SpecExt/Theorem.lean) : `StatementInfo` sépare notamment `kind`, `role`, `epistemicState`, `evidence`, `scope`, `source` et `formalArtifact`, en maintenant aussi des champs de compatibilité historique (`status`, `level`). | C'est le substrat existant le plus riche pour qualifier des objets documentaires. Les valeurs restent largement des chaînes ; ce n'est pas encore un schéma global typé de nœuds et d'arêtes ni une validation automatique de chaque lien. |
| Formules | [`SpecExt.Formula`](../../tools/SpecExt/Formula.lean) : `FormulaInfo` conserve `label`, `kind` et `number`. | Modèle de rendu et de numérotation ; les obligations mathématiques, la preuve et le lien à une implémentation ne sont pas inférés de ces champs. |
| Figures, tableaux et listings | [`SpecExt.Float`](../../tools/SpecExt/Float.lean) : `FloatInfo` décrit le type, le label, l'argument (nom d'asset ou spécification de colonnes), le texte alternatif, la largeur et le numéro ; les slots portent le contenu éditorial. | Contrat de rendu HTML/TeX, non modèle universel d'objet scientifique. Le catalogue de provenance des figures est généré séparément à partir des déclarations Verso et du manifeste TikZ. |
| Bibliographie | [`docs/bibliography/references.json`](../bibliography/references.json) est la source de données active ; [`scripts/biblio/biblio.py`](../../scripts/biblio/biblio.py) produit [`tools/SpecBib.lean`](../../tools/SpecBib.lean). | Le graphe peut extraire une citation explicitement présente, mais une citation n'est pas automatiquement une prémisse d'un résultat. |
| Couverture de la spécification | [`scripts/controles/couverture.py`](../../scripts/controles/couverture.py) rapproche les identifiants normatifs trouvés dans `spec/` d'accroches déclarées dans les commentaires de `src/`; [`scripts/generate_status.py`](../../scripts/generate_status.py) génère `docs/STATUS.md`. | Cette convention produit un rapport de couverture limité. Elle n'est ni un graphe exhaustif de traçabilité ni une preuve de conformité ; `docs/STATUS.md` ne doit pas être édité manuellement. |

**Conclusion du relevé Lean :** K7PL possède des métadonnées locales pour le rendu, les labels, les énoncés et la bibliographie. En revanche, aucune structure globale unique actuellement inventoriée ne relie exhaustivement définition, théorème, preuve, code et tests, avec un type de relation, une provenance et un statut de validation distincts. Il ne faut pas fabriquer cette structure par simple agrégation des noms de modules ou des fichiers voisins.

## 3. Générateurs et validateurs existants

| Composant | Entrée et fonction observées | Statut dans la chaîne |
|---|---|---|
| [`build_figure_provenance.py`](../../scripts/ci/build_figure_provenance.py) | Extrait les déclarations `::::figure`, la description et le texte alternatif, relie chaque figure à sa source graphique, aux rendus, au renderer, au workflow et au manifeste pertinent ; résout aussi le retour vers l'ancre documentaire rendue. | Appelé par le workflow de vérification et produit le catalogue statique des figures. Il décrit la **provenance de génération**, pas un lien scientifique. |
| [`build_semantic_graph.py`](../../scripts/ci/build_semantic_graph.py) | Extrait les rôles `num` et `cite` de plages source explicites et produit une page de graphe avec renvois à la source. Les vues actuelles ciblent deux tranches, C6 et C3. | Appelé dans `verify.yaml` pour les deux pages de graphe. C'est le prototype source-vers-graphe actif, limité à ces plages et types de relations. |
| [`build_navigation_graph.py`](../../scripts/ci/build_navigation_graph.py) | Parcourt le HTML Verso déjà rendu, ses ancres et ses liens ; classe les pages, sections, figures, tableaux, listings, énoncés et entrées bibliographiques. Produit `navigation/index.html` et `navigation/graph.json`, avec une entrée contextuelle depuis chaque page documentaire. | Branché au build du site par `verify.yaml` dans la tranche interactive ; interface avec recherche, profondeur réglable, filtres par relation et liens retour. Résout aussi les URL de type répertoire vers l’`index.html` réellement rendu. Les explications éditoriales progressives sont attachées explicitement par [`navigation_explanations.py`](../../scripts/ci/navigation_explanations.py), avec des ancres sources vérifiables ; elles ne sont pas inférées par le graphe. `check_navigation_graph_output.py` valide la cohérence des sorties. Cela reste une vue de navigation dérivée du HTML, pas un graphe de preuve. |
| [`check_navigation_outputs.py`](../../scripts/ci/check_navigation_outputs.py) | Contrôle les pages de navigation attendues, la fraîcheur de la révision, les liens/fichiers/fragments locaux, les ancres documentaires et les liens GitHub épinglés. | Intégré au workflow de vérification ; la PR #150 a fait passer la relation retour catalogue → page documentaire et la détection de liens périmés sous contrôle automatisé. |
| [`check_spec_html_assets.py`](../../scripts/ci/check_spec_html_assets.py) | Vérifie la correspondance entre déclarations de figures et assets, la résolution des références HTML, les alternatives et descriptions, ainsi que la structure des SVG enrichis. | Intégré au contrôle HTML ; il couvre l'intégrité mécanique des sorties, pas la compréhension par lecteur humain. |
| [`build_tikz_figures.sh`](../../scripts/ci/build_tikz_figures.sh) et [`check_tikz_figures.py`](../../scripts/ci/check_tikz_figures.py) | Génèrent et vérifient des paires PDF/SVG pour les trois sources TikZ répertoriées dans le manifeste. | Chaîne de build et artefacts statiques ; la génération déterministe ne prouve ni l'accessibilité PDF/UA ni l'équivalence visuelle à toute taille d'insertion. |
| [`tikz-poc.yaml`](../../.github/workflows/tikz-poc.yaml) | Compile deux fois les trois figures du POC et compare les sorties produites. | Workflow dédié de reproductibilité du POC ; il ne justifie aucune migration supplémentaire. |

Le workflow de vérification utilise `python3 -m unittest discover -s scripts/ci -p 'test_*.py'` pour les tests de scripts. L'existence de tests automatisés n'implique pas que tous les générateurs soient appelés en production : en particulier, `build_navigation_graph.py` reste distinct de `build_semantic_graph.py`.

## 4. Où vivent les informations — sans confondre leur autorité

| Matériau | Usage légitime pour l'enveloppe | Limite à préserver |
|---|---|---|
| `spec/` | Source Verso canonique des concepts, labels, énoncés, citations, formules et figures. | Son contenu normatif ne peut pas être remplacé par une vue de site ou une inférence du générateur. |
| `src/` | Implémentation Lean et conventions explicites actuelles de couplage couverture, notamment les accroches `Formule`, `Énoncé` et `Regle`. | Une accolade de couverture textuelle ou un nom ressemblant doit être contrôlé selon sa convention ; il ne constitue pas seul une preuve de correspondance sémantique. |
| `tests/` | Tests exécutables et témoins du comportement effectivement exercé. | Aucun lien canonique universel « objet de spec testé par ce test » n'a été établi par le seul inventaire. Ne pas déduire `tested-by` à partir des noms de fichiers. |
| `tools/` et `scripts/` | Extensions Verso, générateurs, validateurs, transformations et règles de CI. | Ce sont des mécanismes de construction/contrôle, pas automatiquement des justifications scientifiques des objets qu'ils manipulent. |
| `docs/` | Architecture, recherche, assurance, décisions, bibliographie, suivi et protocole d'évaluation. | Conserver la distinction entre état courant, décision d'autrice, hypothèse, observation, résultat de test et archive. La présence d'un document dans le site ne le rend pas normatif. |
| `docs/archives/` et `docs/history/` | Provenance historique, dont les configurations Org/LuaLaTeX et certains matériaux de recherche. | Les éléments historiques ne sont pas le contrat courant sans vérification/ratification explicite. |

## 5. Risques de modèle dupliqué

1. **Créer manuellement un JSON/YAML de graphe parallèle.** Les labels, références `num`, citations, déclarations de figures et une partie des champs d'énoncés existent déjà dans les sources. Les recopier créerait deux sources concurrentes et une dette de synchronisation. Les données dérivées doivent rester générées ; une nouvelle annotation ne se justifie que pour une relation importante qui n'est pas exprimée ailleurs.
2. **Confondre labels de rendu et identité scientifique.** Le numéro imprimé change avec l'ordre du document. L'identité doit s'appuyer sur les labels ou des identifiants stables explicites, en conservant la source et la ligne.
3. **Confondre les deux générateurs de graphe.** `build_semantic_graph.py` part d'une sélection de références/citations explicites en source ; `build_navigation_graph.py` part du HTML et peut observer plus largement la structure effectivement rendue. Ils ont des entrées et des garanties différentes. Il serait prématuré de les fusionner ou de les publier tous les deux sans critères comparatifs ; la seconde approche doit rester expérimentale jusqu'à une décision documentée.
4. **Aplatir validation du lien et statut épistémique.** Une relation peut être extraite, vérifiée mécaniquement ou revue par une personne ; la proposition cible peut, indépendamment, être une hypothèse, un résultat, une définition ou un élément historique. Ce sont deux dimensions.
5. **Promouvoir la proximité en preuve.** Les imports Lean, la présence dans un même module, les références bibliographiques et les ressemblances de nom peuvent signaler des pistes ; aucun ne prouve à lui seul une relation `justified-by`, `implemented-by` ou `tested-by`.
6. **Utiliser le rendu dérivé comme source canonique.** Le HTML est approprié pour vérifier les ancres et le comportement du document généré. Pour établir le sens d'une référence explicite, les sources Verso restent plus proches de la relation déclarée ; un contrôle du HTML ne remplace pas l'interprétation de la source.

## 6. État d'avancement et portes restantes

### Établi statiquement

- La source canonique de la spécification et la version déclarée de Verso sont identifiées.
- Les extensions Lean utilisées pour les labels, slots, énoncés, formules, figures et citations ont été inventoriées.
- Les générateurs, validateurs et flux de production des vues et figures existantes sont recensés.
- La séparation entre source canonique, artefact généré et documentation historique est explicite.
- La clôture mécanique de la réversibilité du catalogue après la PR #150 est couverte par des contrôles CI.

### Non établi par cet inventaire

- L'utilité de la navigation pour des lecteurs non familiers ; aucune session comparative n'est rapportée.
- Le fonctionnement effectif des URL publiques dans un navigateur, y compris mobile, clavier et JavaScript désactivé.
- La conformité PDF/UA du PDF réellement produit par la chaîne Org/LuaLaTeX personnelle, l'ordre de lecture et l'interprétation par lecteur d'écran.
- La lisibilité éditoriale des trois figures à taille d'insertion et en niveaux de gris, revue par une personne indépendante.
- L'exactitude ou l'exhaustivité d'un futur graphe définition → théorème → preuve → implémentation → test.

**Décision de portée :** cet inventaire clôt le relevé documentaire P0 seulement. Il n'autorise ni élargissement du graphe sémantique, ni revendication d'accessibilité PDF/UA, ni migration globale des figures. Les prochains jalons restent la vérification humaine sur les artefacts effectivement publiés et l'évaluation comparative préenregistrée du parcours de provenance ; toute extension dépend de preuves de valeur et de relations explicites.

## Références de suivi

- [Plan d'exploration interactive](INTERACTIVE-EXPLORATION-PLAN.md)
- [Modèle sémantique minimal](NAVIGATION-SEMANTIC-MODEL.md)
- [Prototype de navigation](NAVIGATION-PROTOTYPE.md)
- [Audit des figures et du rendu](DIAGRAMS-AND-RENDERING-AUDIT.md)
- [Résultats du POC TikZ](tikz-poc/RESULTS.md)
