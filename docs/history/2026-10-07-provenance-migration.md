# Provenance des documents

Chaque fichier de `docs/` et d'`archives/` vient du dossier de travail que vous avez fourni (`K7PL_spec.zip`). Ce tableau dit d'où, et ce qui a été fait. **Le contenu n'a pas été modifié** ; les fichiers Org ont été convertis en Markdown (`scripts/org2md.py`, pandoc), les rapports `.docx` aussi.

## Non repris dans le dépôt

| Élément | Raison |
|---|---|
| `biblio/K7PL-Biblio.bib`, `biblio/refs-pour-citations.bib` (7 Mo chacun) | bibliothèque Zotero complète : résumés d'éditeurs (textes de tiers), chemins de fichiers locaux. Seules les 250 notices citées par la spécification sont reprises, sans résumés ni chemins : [`docs/bibliography/references.json`](../bibliography/references.json) |
| `biblio/pdf-index.json` (4,7 Mo) | index du texte de PDF d'articles (extraits de tiers, chemins locaux) |
| `src/main.pdf`, `main.tex`, `main.bbl`, `main.lof`, `main.lot`, `main.lst`, `main.synctex.gz`, `main-luamml-mathml.html` | produits de compilation, périmés (9 septembre) et regénérés par la CI |
| `src/chapitres/ltximg/` | images intermédiaires de l'export |
| `biblio/references.json` | `docs/bibliography/references.json` | notices bibliographiques sélectionnées, conservées comme source machine active |
| `biblio/A-CORRIGER-resumes.md`, `A-DEPLACER-cles.md`, `A-IMPORTER-solde.md`, `A-VERSER-collection.md` | quatre pastilles « PÉRIMÉ » de 183 octets, sans contenu |
| `#+EMAIL:` de `main.org` | adresse professionnelle, retirée de la copie d'archive |
| résumés d'éditeurs de `meta/corpus.org` (633 blocs `#+BEGIN_ABSTRACT`) | textes de tiers ; les synthèses et analyses de l'auteur sont conservées |

## Tableau de correspondance

| Origine (ancien dossier de travail) | Destination | Traitement |
|---|---|---|
| `meta/registre-obligations.org` | `docs/tracking/registre-obligations.md` | org → md |
| `meta/registre-empirique.org` | `docs/tracking/registre-empirique.md` | org → md |
| `meta/factorisations-refusees.org` | `docs/tracking/factorisations-refusees.md` | org → md |
| `meta/correspondance-theoremes.org` | `docs/history/correspondance-theoremes-org.md` | org → md |
| `meta/primitives.org` | `docs/tracking/primitives.md` | org → md |
| `livrables/PLAN-PR-02.md` | `docs/history/pr-02-plan-de-traitement.md` | copie + bandeau |
| `Peer-Review/PR_02/K7PL_PR_02_CLAUDE.docx` | `docs/peer-review/pr-02/claude.md` | docx → md |
| `Peer-Review/PR_02/K7PL_PR_02_FLASH.docx` | `docs/peer-review/pr-02/flash.md` | docx → md |
| `Peer-Review/PR_02/K7PL_PR_02_DEEPSEEK.md` | `docs/peer-review/pr-02/deepseek.md` | copie |
| `Peer-Review/PR_02/K7PL_PR_02_GEMINI.md` | `docs/peer-review/pr-02/gemini.md` | copie |
| `Peer-Review/PR_02/K7PL_PR_02_GPT.md` | `docs/peer-review/pr-02/gpt.md` | copie |
| `Peer-Review/PR_02/K7PL_PR_02_QWEN.md` | `docs/peer-review/pr-02/qwen.md` | copie |
| `Peer-Review/PR_02/K7PL_contributions_formelles.md` | `docs/peer-review/pr-02/etudes/contributions-formelles.md` | copie |
| `Peer-Review/PR_02/K7PL_etude_opportunite_HoTT.md` | `docs/peer-review/pr-02/etudes/etude-opportunite-hott.md` | copie |
| `Peer-Review/PR_02/K7PL_programme_concurrence.md` | `docs/peer-review/pr-02/etudes/programme-concurrence.md` | copie |
| `Peer-Review/PR_02/K7PL_taches_consolidees_PR02.md` | `docs/peer-review/pr-02/taches-consolidees.md` | copie |
| `livrables/RELECTURES-TRIAGE.md` | `docs/peer-review/pr-01/2026-09-08-relectures-triage.md` | copie |
| `livrables/CONFORMITE-GPT.md` | `docs/peer-review/pr-01/2026-09-09-conformite-gpt.md` | copie |
| `livrables/CONFORMITE-APPLIQUEE.md` | `docs/peer-review/pr-01/2026-09-09-conformite-appliquee.md` | copie |
| `livrables/AVANT-RELECTURE-2.md` | `docs/peer-review/pr-01/2026-09-09-avant-relecture-2.md` | copie |
| `livrables/PASSE-THEOREMES.md` | `docs/history/2026-09-07-passe-theoremes.md` | copie |
| `livrables/SEANCE-09-09.md` | `docs/history/2026-09-09-seance.md` | copie |
| `livrables/INSTRUCTION-G-01-G-05-G-06.md` | `docs/history/2026-09-08-instruction-g-01-g-05-g-06.md` | copie |
| `livrables/PR-02-BLOQ-03-ET-06.md` | `docs/history/2026-09-30-pr-02-01-bloq-03-et-06.md` | copie |
| `livrables/PR-02-VAGUE-0.md` | `docs/history/2026-09-30-pr-02-02-vague-0.md` | copie |
| `livrables/PR-02-VAGUE-0-FIN.md` | `docs/history/2026-09-30-pr-02-03-vague-0-fin.md` | copie |
| `livrables/PR-02-COUCHE-3-PARALLELE.md` | `docs/history/2026-09-30-pr-02-04-couche-3-parallele.md` | copie |
| `livrables/PR-02-COUCHE-2.md` | `docs/history/2026-10-01-pr-02-05-couche-2.md` | copie |
| `livrables/PR-02-THEOREMES.md` | `docs/history/2026-10-01-pr-02-06-theoremes.md` | copie |
| `livrables/PR-02-NON-INTERFERENCE-ET-FACT.md` | `docs/history/2026-10-01-pr-02-07-non-interference-et-fact.md` | copie |
| `livrables/PR-02-FACT-SUITE.md` | `docs/history/2026-10-01-pr-02-08-fact-suite.md` | copie |
| `livrables/PR-02-PORT-ET-FACT2.md` | `docs/history/2026-10-01-pr-02-09-port-et-fact2.md` | copie |
| `livrables/PR-02-FACT-SECOND-RANG.md` | `docs/history/2026-10-01-pr-02-10-fact-second-rang.md` | copie |
| `meta/doctrine.org` | `docs/method/doctrine.md` | org → md |
| `meta/protocole.org` | `docs/method/protocole.md` | org → md |
| `livrables/CHARTE-REDACTION.md` | `docs/method/charte-redaction.md` | copie |
| `livrables/DOCTRINE-E.md` | `docs/method/doctrine-e.md` | copie |
| `meta/questions.org` | `docs/research/questions.md` | org → md |
| `meta/corpus.org` | `docs/research/corpus.md` | org → md (résumés éditeurs retirés) |
| `meta/manques.org` | `docs/research/manques.md` | org → md |
| `meta/arcG-methode.org` | `docs/research/arc-g-methode.md` | org → md |
| `meta/arcG-collecte.org` | `docs/research/arc-g-collecte.md` | org → md |
| `meta/rapport-QA-28.org` | `docs/research/rapport-qa-28.md` | org → md |
| `livrables/ANALYSE-B-ET-F.md` | `docs/research/2026-09-08-analyse-b-et-f.md` | copie |
| `livrables/ANALYSE-B-APPROFONDIE.md` | `docs/research/2026-09-08-analyse-b-approfondie.md` | copie |
| `livrables/FOCUS-F-ROUTE-4.md` | `docs/research/2026-09-09-focus-f-route-4.md` | copie |
| `biblio/A-AJOUTER-collection.md` | `docs/bibliography/a-ajouter-collection.md` | copie |
| `biblio/A-CHARGER.md` | `docs/bibliography/a-charger.md` | copie |
| `biblio/A-CORRIGER-resumes.md` | — | omis : pastille « PÉRIMÉ » de 183 octets, sans contenu |
| `biblio/A-DEPLACER-cles.md` | — | omis : pastille « PÉRIMÉ » de 183 octets, sans contenu |
| `biblio/A-IMPORTER-solde.md` | — | omis : pastille « PÉRIMÉ » de 183 octets, sans contenu |
| `biblio/A-SOURCER-manques.md` | `docs/bibliography/a-sourcer-manques.md` | copie |
| `biblio/A-SOURCER-nommage.md` | `docs/bibliography/a-sourcer-nommage.md` | copie |
| `biblio/A-TRAITER.md` | `docs/bibliography/a-traiter.md` | copie |
| `biblio/A-VERSER-collection.md` | — | omis : pastille « PÉRIMÉ » de 183 octets, sans contenu |
| `biblio/decisions-bibliographiques.json` | `docs/bibliography/decisions-bibliographiques.json` | copie |
| `meta/plan.org` | `docs/history/2026-09-02-plan.md` | org → md |
| `meta/todo-manuscrit.org` | `docs/history/2026-09-02-todo-manuscrit.md` | org → md |
| `meta/strategie.org` | `docs/history/2026-09-02-strategie.md` | org → md |
| `meta/arbitrages.org` | `docs/history/2026-09-02-arbitrages.md` | org → md |
| `meta/theoremes.org` | `docs/history/2026-09-02-theoremes-rediges.md` | org → md |
| `livrables/ARBITRAGES-OUVERTS.md` | `docs/history/2026-09-08-arbitrages-ouverts.md` | copie + bandeau |
| `livrables/PLAN-REALISATION.md` | `docs/history/2026-09-08-plan-realisation.md` | copie + bandeau |
| `livrables/REFONTE-OUTILLAGE.md` | `docs/history/2026-09-08-refonte-outillage.md` | copie + bandeau |
| `livrables/EVOLUTIONS-STYLE.md` | `docs/history/2026-09-04-evolutions-style.md` | copie |
| `livrables/PDF-AMELIORATIONS.md` | `docs/history/2026-09-04-pdf-ameliorations.md` | copie |
| `livrables/CORRECTIONS-EMACS.md` | `docs/history/2026-09-07-corrections-emacs.md` | copie |
| `livrables/REMISE-EMACS-07-09.md` | `docs/history/2026-09-07-remise-emacs.md` | copie |
| `livrables/REMISE-EMACS-08-09.md` | `docs/history/2026-09-08-remise-emacs.md` | copie + bandeau |
| `livrables/CASCADE-POLICES.md` | `docs/history/2026-09-05-cascade-polices.md` | copie + bandeau |
| `livrables/PR-02-AVANCEMENT.md` | `docs/history/2026-10-01-pr-02-avancement.md` | copie + bandeau |
| `src/chapitres/annexes.org` | `docs/archives/manuscrit-org/chapitres/annexes.org` | copie |
| `src/chapitres/c1-prolegomenes.org` | `docs/archives/manuscrit-org/chapitres/c1-prolegomenes.org` | copie |
| `src/chapitres/c2-fondements.org` | `docs/archives/manuscrit-org/chapitres/c2-fondements.org` | copie |
| `src/chapitres/c3-types.org` | `docs/archives/manuscrit-org/chapitres/c3-types.org` | copie |
| `src/chapitres/c4-automates.org` | `docs/archives/manuscrit-org/chapitres/c4-automates.org` | copie |
| `src/chapitres/c5-syntaxe.org` | `docs/archives/manuscrit-org/chapitres/c5-syntaxe.org` | copie |
| `src/chapitres/c6-compilation.org` | `docs/archives/manuscrit-org/chapitres/c6-compilation.org` | copie |
| `src/chapitres/c7-integration.org` | `docs/archives/manuscrit-org/chapitres/c7-integration.org` | copie |
| `src/chapitres/refs.org` | `docs/archives/manuscrit-org/chapitres/refs.org` | copie |
| `src/K7PL-glossary.org` | `docs/archives/manuscrit-org/K7PL-glossary.org` | copie |
| `src/K7_Errors.org` | `docs/archives/manuscrit-org/K7_Errors.org` | copie |
| `src/K7_LSP_REPL.org` | `docs/archives/manuscrit-org/K7_LSP_REPL.org` | copie |
| `src/K7_Semantique.org` | `docs/archives/manuscrit-org/K7_Semantique.org` | copie |
| `src/K7_Sugoi.org` | `docs/archives/manuscrit-org/K7_Sugoi.org` | copie |
| `src/K7_Sushi.org` | `docs/archives/manuscrit-org/K7_Sushi.org` | copie |
| `src/main.org` | `docs/archives/manuscrit-org/main.org` | copie, ligne `#+EMAIL:` retirée (adresse professionnelle) |
| `outils/construire.py` | `docs/archives/outillage-org/outils/construire.py` | copie |
| `outils/controle.py` | `docs/archives/outillage-org/outils/controle.py` | copie |
| `outils/corpus.py` | `docs/archives/outillage-org/outils/corpus.py` | copie |
| `outils/correspondance.py` | `docs/archives/outillage-org/outils/correspondance.py` | copie |
| `outils/filtres.py` | `docs/archives/outillage-org/outils/filtres.py` | copie |
| `outils/legendes_export.py` | `docs/archives/outillage-org/outils/legendes_export.py` | copie |
| `outils/mesure.py` | `docs/archives/outillage-org/outils/mesure.py` | copie |
| `outils/pdf.py` | `docs/archives/outillage-org/outils/pdf.py` | copie |
| `outils/registre.py` | `docs/archives/outillage-org/outils/registre.py` | copie |
| `outils/controles/__init__.py` | `docs/archives/outillage-org/outils/controles/__init__.py` | copie |
| `outils/controles/algebre.py` | `docs/archives/outillage-org/outils/controles/algebre.py` | copie |
| `outils/controles/citations.py` | `docs/archives/outillage-org/outils/controles/citations.py` | copie |
| `outils/controles/croise.py` | `docs/archives/outillage-org/outils/controles/croise.py` | copie |
| `outils/controles/figures.py` | `docs/archives/outillage-org/outils/controles/figures.py` | copie |
| `outils/controles/glossaire.py` | `docs/archives/outillage-org/outils/controles/glossaire.py` | copie |
| `outils/controles/journal.py` | `docs/archives/outillage-org/outils/controles/journal.py` | copie |
| `outils/controles/notation.py` | `docs/archives/outillage-org/outils/controles/notation.py` | copie |
| `outils/controles/semantique.py` | `docs/archives/outillage-org/outils/controles/semantique.py` | copie |
| `outils/controles/source.py` | `docs/archives/outillage-org/outils/controles/source.py` | copie |
| `outils/controles/structure.py` | `docs/archives/outillage-org/outils/controles/structure.py` | copie |
| `livrables/my-export-config.el` | `docs/archives/outillage-org/my-export-config.el` | copie |
| `livrables/preamble-article.tex` | `docs/archives/outillage-org/preamble-article.tex` | copie |
| `Makefile` | `docs/archives/outillage-org/Makefile` | copie |
| `README.org` | `docs/archives/outillage-org/README-ancien-dossier.md` | org → md |
| `biblio/arcs.json` | `docs/archives/outillage-org/donnees/arcs.json` | copie |
| `biblio/confusables-glyphes.json` | `docs/archives/outillage-org/donnees/confusables-glyphes.json` | copie |
| `biblio/sondes.json` | `docs/archives/outillage-org/donnees/sondes.json` | copie |
| `biblio/non-regression-v64.json` | `docs/archives/outillage-org/donnees/non-regression-v64.json` | copie |
| `biblio/refs.json` | `docs/archives/outillage-org/donnees/refs.json` | copie |
