<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Language migration backlog

**Status:** IN PROGRESS. Inventory of the French text that remains outside `spec/`.
**Snapshot:** `main` at `7af5581`, plus the branch `docs/english-policy` that introduces this file.
**Nature:** tracking register. It lists work; the owner's decisions of 2026-10-19 are recorded under "Rule".

## Rule

Owner's rule, verbatim: « seule la spec/ est en français, le reste doit être en anglais »
("only spec/ is in French; everything else must be in English"). Code, identifiers, comments,
docstrings, documentation, tracking, agent and rule files, issues, pull requests and commit messages
are written in English. The rule is stated in [`CONTRIBUTING.md`](../../CONTRIBUTING.md#languages),
[`.claude/CLAUDE.md`](../../.claude/CLAUDE.md), [`.claude/rules/documentation.md`](../../.claude/rules/documentation.md)
and [`.claude/skills/writing-rules.md`](../../.claude/skills/writing-rules.md), §2. No CI check
enforces it.

**Owner's decisions of 2026-10-19** (answers to the questions this register raised):

- historical and evidence records (category (c)) are **not translated**. They are kept as they are
  until their content has been analysed and arbitrated (moved elsewhere, abandoned, etc.), then
  **deleted progressively**; each deletion records where the content went or why it was abandoned;
- the specification stays in French: strings rendered into it (category (d), and the fixtures that
  mirror its text) follow it and stay French;
- **file names are in English**: the French file names outside `spec/` are to be renamed (see
  "Coupled changes": several are read by scripts and tests). Whether module file names under
  `spec/` are renamed as well is not yet decided.

## Already translated

| File | State |
|---|---|
| `.claude/CLAUDE.md`, `.claude/rules/*.md` (6 files), `.claude/skills/writing-rules.md` | translated on `docs/english-policy`, pending merge |
| `CONTRIBUTING.md`, `README.md` | translated on `docs/english-policy`, pending merge (`README.md` includes the sections merged by PR #232) |
| `.github/PULL_REQUEST_TEMPLATE.md`, `.github/ISSUE_TEMPLATE/*.yml` (3 files) | translated on `docs/english-policy`, pending merge |
| `CHANGELOG.md`, `docs/tracking/BRANCHES-STATUS.md` | done on `main` (PR #227) |
| `LICENSE.md` | in progress in open PR #233 (translation and path-to-license map); still French on `main` |
| `docs/README.md`, `docs/ARCHITECTURE.md`, `docs/ASSURANCE.md`, `docs/METHOD.md`, `docs/RESEARCH.md`, `docs/tracking/DASHBOARD.md`, `docs/migration/README.md`, `docs/peer-review/README.md` | already English (their first heading is checked by `scripts/ci/check_documentation_architecture.py`) |

## Detection method

The inventory comes from two passes over the files tracked by Git, run from the repository root.
`spec/`, `LICENSES/` (license texts) and this file are excluded.

**Pass 1, French lines.** A line counts as French when it has at least three points, one point per
French function word from a fixed list plus one point if it contains a French accented letter, and
more French than English function words. Identifiers containing `_` are removed first, so that
Lean names such as `le_rfl` do not count. The script prints `category<TAB>lines<TAB>path`; the
category rules are those of the sections below.

```python
import re, subprocess

FR = set("le la les des du une est et pour dans avec sur qui que au aux cette ces sont ou nous être pas leur sans".split())
EN = set("the and of to is in for with on that this are be not by from".split())
ACCENT = re.compile(r"[éèêàçùûôîœ]")
WORD = re.compile(r"[^\W\d_]+")
IDENT = re.compile(r"\w*_\w*")  # drop identifiers such as `le_rfl` before counting words


def is_french(line):
    low = IDENT.sub(" ", line.lower())
    words = WORD.findall(low)
    fr = sum(w in FR for w in words)
    en = sum(w in EN for w in words)
    return fr + bool(ACCENT.search(low)) >= 3 and fr > en


GENERATED = {"docs/STATUS.md", "docs/tracking/FICHES-PR02.md", "docs/tracking/correspondance-enonces.md",
             "tools/SpecBib.lean", "docs/migration/LEGACY-INVENTORY.md"}
RECORD_PREFIXES = ("docs/archives/", "docs/history/", "docs/peer-review/", "docs/security/workstreams/",
                   "docs/tracking/tikz-poc/")
METADATA = {"CITATION.cff", "zenodo.json", "zenodo.files.json"}
CODE_SUFFIXES = (".py", ".sh", ".lean", ".yaml", ".yml", ".toml", ".json", ".js", ".css", ".k7")


def category(path):
    name = path.rsplit("/", 1)[-1]
    if path in GENERATED:
        return "b"
    if path.startswith(RECORD_PREFIXES) or path == "docs/security/IMPLEMENTATION-STATUS.md" or (
            path.startswith("docs/") and (re.search(r"\d{4}-\d{2}-\d{2}", name) or "AUDIT" in name)):
        return "c"
    if path not in METADATA and not path.startswith("docs/") and path.endswith(CODE_SUFFIXES):
        return "d"
    return "a"


SKIP = ("spec/", "LICENSES/", "docs/tracking/LANGUAGE-MIGRATION.md")
paths = subprocess.run(["git", "ls-files", "-z"], capture_output=True, check=True).stdout.decode().split("\0")
for path in sorted(p for p in paths if p and not p.startswith(SKIP)):
    try:
        lines = open(path, encoding="utf-8").read().splitlines()
    except (UnicodeDecodeError, OSError):
        continue
    hits = sum(map(is_french, lines))
    if hits:
        print(f"{category(path)}\t{hits}\t{path}")
```

Save the block outside the repository and run `python3 -I <file>` from the repository root.

**Pass 2, short strings.** Pass 1 misses short French strings (labels, single words, headings).
Files containing a French accented letter, then compared with the output of pass 1:

```sh
LC_ALL=C.UTF-8 git ls-files -z -- ':!spec/' ':!LICENSES/' ':!docs/tracking/LANGUAGE-MIGRATION.md' \
  | LC_ALL=C.UTF-8 xargs -0 grep -l -I -P '\w*[éèêàçùûôîœ]'
```

**Limits.**

- Heuristic, not a language identifier. A sample of 25 lines drawn at random from the pass 1
  matches were all French; recall was not measured.
- The line counts are lower bounds: short French lines (headings such as `# Rôle`, one-clause
  sentences) are not counted. Use the file list, not the counts, to plan work.
- Pass 2 also matches proper names (author names in the bibliography) and misses French written
  without accents.
- The categories come from path rules. Some files sit on a boundary (see "Boundary cases").
- The snapshot ages: rerun both passes before relying on it.

## Summary

| Category | Files | French lines (pass 1, lower bound) |
|---|--:|--:|
| (a) Living documents | 94 | 7,118 |
| (b) Generated files | 3 | 150 |
| (c) Historical and evidence records | 198 | 14,318 |
| (d) Code comments and strings | 36 | 200 |
| **Total, pass 1** | **331** | **21,786** |
| Pass 2 only (short strings, see (d) and (b)) | 32 | — |

## (a) Living documents — to translate

Indexes, registers, plans, guides and policies that the project keeps current.

| Area | Files | Paths |
|---|--:|---|
| Root community files and metadata | 6 | `CODE_OF_CONDUCT.md` (French translation of Contributor Covenant 2.1), `SECURITY.md`, `LICENSE.md` (PR #233), `CITATION.cff` (abstract), `zenodo.json`, `zenodo.files.json` (descriptions) |
| Agent definitions | 8 | `.claude/agents/`: `consistency-auditor`, `formal-reviewer`, `lean-debugger`, `lean-implementer`, `spec-architect`, `spec-editor`, `theorem-prover`, `verification-specialist` (the six assurance agents are already English) |
| Skills | 15 | every `SKILL.md` under `.claude/skills/engineering/`, `lean/`, `research/` and `spec/` |
| CI documentation | 1 | `.github/workflows/README.md` |
| READMEs next to code | 3 | `scripts/ci/navigation_graph/README.md`, `scripts/org2verso/README.md`, `tools/prototypes-bcd/README.md` (translated when `tooling/` was folded into `tools/`) |
| `docs/` root | 1 | `docs/PROVENANCE.md` (partly French) |
| `docs/tracking/` | 15 | `DECISIONS.md`, `INTERACTIVE-EXPLORATION.md`, `INTERACTIVE-EXPLORATION-INVENTORY.md`, `INTERACTIVE-EXPLORATION-PLAN.md`, `LEAN-STATEMENT-MIGRATION.md`, `NAVIGATION-PROTOTYPE.md`, `NAVIGATION-SEMANTIC-MODEL.md`, `PROJECT-MASTER-PLAN.md`, `PROOF-VISUALIZATION-COVERAGE.md`, `PROOF-VISUALIZATION-HUMAN-REVIEW.md`, `PROOF-VISUALIZATION-ROADMAP.md`, `factorisations-refusees.md`, `fiches-statuts.csv`, `hypotheses-de-module.md`, `primitives.md` |
| `docs/security/` | 12 | `ACTIONS-HUMAINES.md`, `ASSURANCE-CASE.md`, `BADGE-AUTOMATION.md`, `BADGE-CONFORMANCE-MATRIX.md`, `DECISIONS-REQUISES.md`, `GOVERNANCE.md`, `LEAN-SECURITY-TOOLCHAIN.md`, `OPENSSF-ROADMAP.md`, `README.md`, `SECRETS-POLICY.md`, `THREAT-MODEL.md`, `TOOLING-EVALUATION.md` |
| `docs/method/` | 4 | `charte-redaction.md`, `doctrine.md`, `doctrine-e.md`, `protocole.md` |
| `docs/research/` (undated) | 14 | `LEAN-COMPLIANCE-ASSURANCE.md`, `LEAN-COMPLIANCE-DECISION.md`, `SPDX-NEGATIVE-CORPUS-REVIEW.md`, `ancienne-annexe-e-preambule.md`, `arc-g-collecte.md`, `arc-g-methode.md`, `commentaires-du-manuscrit.md`, `corpus.md` (2,507 lines), `instruction-arb-pr-04-rejeu-binaire.md`, `manques.md`, `questions.md`, `rapport-qa-28.md`, `registre-empirique.md`, `sources-singularites.md` |
| `docs/migration/` registers | 5 | `L1-ANNEXES-EXTRACTION.md`, `L1-DECISIONS.md`, `L1-SUIVI-EXTRACTION.md`, `L1-THEORY-OBJECTS.md`, `L1-THEORY-SEDIMENTATION.md` |
| Experimental K → Lean chain (PR #232) | 3 | `CHECKPOINT.md` (dated 18 October 2026), `docs/formal-semantics.md`, `proofs/README.md` |
| `docs/bibliography/` | 7 | `a-ajouter-collection.md`, `a-charger.md`, `a-sourcer-manques.md`, `a-sourcer-nommage.md`, `a-traiter.md`, `verifications-pr02.md`, `decisions-bibliographiques.json` (French `motif` fields) |

Translating the content of a file does not rename it: French file names (for example
`ACTIONS-HUMAINES.md`, `fiches-statuts.csv`) are referenced by scripts, workflows and other
documents, and a rename is a separate change (open question 6).

## (b) Generated files — translate the generator, not the output

| Generated file | Generator | Where the French comes from |
|---|---|---|
| `docs/STATUS.md` | `scripts/generate_status.py` (CI); the coverage block is written by `scripts/controles/couverture.py` | French strings in `couverture.py` |
| `docs/tracking/FICHES-PR02.md` | `python3 scripts/suivi.py fiches` | card titles copied from `docs/peer-review/pr-02/taches-consolidees.md` (a record, category (c)) and notes from `docs/tracking/fiches-statuts.csv` |
| `docs/tracking/correspondance-enonces.md` | `python3 scripts/suivi.py enonces` | the heading is in `scripts/suivi.py`; the statement titles are extracted from `spec/` and are French by origin |
| `tools/SpecBib.lean` (pass 2 only) | `scripts/biblio/biblio.py` from `docs/bibliography/references.json` | bibliographic data (author names, titles of cited works), not prose to translate |

## (c) Historical and evidence records — not translated, deleted after arbitration

Owner's decision of 2026-10-19: these records are not translated. Each is kept until its content has
been analysed and arbitrated (moved elsewhere, abandoned, etc.), then deleted. The table below is
therefore also the inventory of records still to arbitrate.

| Area | Files | French lines |
|---|--:|--:|
| `docs/archives/` (frozen: `manuscrit-org/` 15, `outillage-org/` 29, root 1; never edited to change the current version) | 45 | 2,662 |
| `docs/history/` | 92 | 4,632 |
| `docs/peer-review/` (`pr-01/` 4, `pr-02/` 10) | 14 | 3,524 |
| `docs/migration/`: dated files and audits (`C-07-SIMULATION-AUDIT.md`, `L1-T68-AUDIT.md`, and the 25 `L1-*-2026-10-1x.md` files) | 27 | 1,313 |
| `docs/research/`: dated analyses (`2026-09-08-analyse-b-approfondie.md`, `2026-09-08-analyse-b-et-f.md`, `2026-09-09-focus-f-route-4.md`) | 3 | 291 |
| `docs/security/`: `OPENSSF-AUDIT.md`, `IMPLEMENTATION-STATUS.md` (dated record) and the 13 files under `workstreams/` | 15 | 1,840 |
| `docs/tracking/tikz-poc/` (closed on 14 October 2026) | 2 | 56 |

Dated audits in this category cite line numbers and French passages of `README.md`,
`CONTRIBUTING.md` and `.claude/CLAUDE.md` (for example `docs/security/workstreams/cii/AUDIT.md`);
those citations describe the files as they were and no longer match the translated files.

## (d) Code comments and strings

| Area | Files | Paths | Nature |
|---|--:|---|---|
| Workflows | 5 | `.github/workflows/bump-lean.yaml`, `ci.yaml`, `release.yaml`, `verify.yaml`, `zenodo.yaml` | comments, `::error::` messages, release notes text |
| Configuration comments | 2 | `.howfairis.yml`, `REUSE.toml` | comments |
| `scripts/ci/` | 8 | `build_figure_provenance.py`, `build_proof_visualizations.py`, `build_semantic_graph.py`, `impact.py`, `test_build_proof_visualizations.py`, `navigation_graph/build_navigation_graph.py`, `navigation_graph/navigation_explanations.py`, `navigation_graph/test_navigation_graph.py` | messages, docstrings; `navigation_explanations.py` holds the French texts of the generated site |
| `scripts/controles/` | 9 | `algebre.py`, `couverture.py`, `croise.py`, `donnees/sondes.json`, `indexation.py`, `notation.py`, `semantique.py`, `statement_ontology.py`, `structure.py` | check messages; `sondes.json` holds passages that must match the French spec text |
| Other scripts | 3 | `scripts/org2verso/convert.py`, `scripts/suivi.py`, `scripts/sync_zenodo.py` | messages, generated headings |
| Tests | 4 | `tests/SpecToolsTest.lean`, `tests/python/conftest.py`, `tests/python/test_controles.py`, `tests/python/test_stage_c_interface_audit.py` | fixtures that mirror French spec text, assertions on French documents |
| `tools/prototypes-bcd/` | 3 | `AnnexB.lean`, `AnnexC.lean`, `AnnexD.lean` | text extracted from the former annexes B, C and D |
| `tools/SpecExt/` | 2 | `ProofVisualization.lean`, `Translate.lean` | strings rendered into the French specification (HTML and PDF) |

Pass 2 adds 32 files with short French strings: `lib/lib-exemple.k7` (a comment in a K7PL library
file); `scripts/biblio/biblio.py`, `scripts/controle.py`, `scripts/controles/statement_inventory.py`,
`scripts/inventory_legacy.py`, `scripts/org2verso/emit.py`, `scripts/org2verso/orgparse.py`,
`scripts/verif_singularites.py`, `scripts/ci/test_sync_zenodo.py`,
`scripts/ci/test_code_artifact_contract.py` (asserts French headings of `spec/Spec/CodeArtifacts.lean`),
`scripts/ci/navigation_graph/check_navigation_graph_output.py`,
`scripts/ci/navigation_graph/test_navigation_graph_output.py`; eight test files under `tests/python/`
(`test_build_figure_provenance.py`, `test_build_semantic_graph.py`, `test_check_navigation_outputs.py`,
`test_journal.py`, `test_manuscript_metrics.py`, `test_stage_c_substitution_audit.py`,
`test_statement_ontology.py`, `test_suivi.py`); `tools/SpecMain.lean` and six `tools/SpecExt/`
modules (`Cite.lean`, `IndexCore.lean`, `IndexTerms.lean`, `Label.lean`, `Setup.lean`,
`Theorem.lean`), whose strings are labels of the French specification ("Théorème", "Références",
"Table des matières", index terms); the bibliographic data `docs/bibliography/references.json` and
`tools/SpecBib.lean`; and three English documents that quote French vocabulary
(`docs/migration/L1-SUIVI.md`, `docs/migration/L5-VALIDATION.md`, `docs/tracking/BRANCHES-STATUS.md`).

## Coupled changes

Some French strings are read by code. Translating them in one place without the other breaks a
check or a parser; each pair must change in the same commit.

| French text | Read by |
|---|---|
| Passages of `docs/migration/L1-C01-C02-TYPED-INTERFACE-AUDIT-2026-10-11.md`, `L1-THEORY-OBJECTS.md`, `L1-C-EFFECTIVE-RULE-EVIDENCE-MATRIX-2026-10-12.md`, `L1-C06-SUBSTITUTION-AUDIT-2026-10-11.md` (for example "Porte C globale : NON SATISFAITE") | assertions in `tests/python/test_stage_c_interface_audit.py`, `test_stage_c_effective_rule_matrix.py`, `test_stage_c_substitution_audit.py` |
| Headings "### 2. Inventaire détaillé" and "### 3. Classification sémantique encore requise" of `docs/tracking/LEAN-STATEMENT-MIGRATION.md` | `scripts/controles/statement_inventory.py` |
| Column names and status values of `docs/tracking/fiches-statuts.csv` (`statut`, `confiance`, `fermee`…) and the lot headings of `docs/peer-review/pr-02/taches-consolidees.md` | `scripts/suivi.py` and `tests/python/test_suivi.py` |
| Release-notes heading "Avant publication" written by `.github/workflows/release.yaml` | quoted in `CONTRIBUTING.md` (publishing a specification release, step 4) |
| UI strings of the generated navigation page | `scripts/ci/navigation_graph/check_navigation_graph_output.py` and its tests |
| Coupling-anchor keywords `Formule`, `Énoncé`, `Regle` in `src/` comments | `scripts/controles/couverture.py` (no anchor is present in `src/` at this snapshot) |
| Epistemic-state vocabulary (`établi`, `hypothèse`, `décision`…) | `scripts/inventory_legacy.py`, quoted in `docs/migration/L1-SUIVI.md` |

## Boundary cases

The path rules may misclassify a few files; the owner may move them between (a) and (c):

- in (a) but dated or self-described as a record: `CHECKPOINT.md` (checkpoint of 18 October 2026,
  which still describes PR #232 as open), `docs/security/THREAT-MODEL.md` ("dated state of
  knowledge"), `docs/security/BADGE-CONFORMANCE-MATRIX.md` (dated re-evaluation),
  `docs/bibliography/verifications-pr02.md`, `docs/research/rapport-qa-28.md`;
- in (c) but referenced as current by living registers: the dated decision and ratification files
  `docs/migration/L1-D*-2026-10-11.md` and `L1-C01-INTERFACE-RATIFICATION-2026-10-11.md`.

## Open questions for the owner

1. ~~Records (category (c)): translate, keep as they are, or add English summaries?~~ Decided
   2026-10-19: not translated; deleted progressively after arbitration.
2. Strings rendered into the French specification (`tools/SpecExt/`, `scripts/biblio/biblio.py`
   output, `navigation_explanations.py`): they belong to the French deliverable; do they count as
   part of `spec/` for the language rule and stay French? Decided 2026-10-19: they stay French.
3. Test fixtures and probes that mirror French spec text (`tests/python/conftest.py`,
   `tests/python/test_controles.py`, `tests/SpecToolsTest.lean`, `scripts/controles/donnees/sondes.json`):
   they must follow the language of `spec/`; confirm that they stay French. Follows from the
   2026-10-19 decision: they stay French.
4. `tools/prototypes-bcd/*.lean`: former annex text, outside `spec/` since `d84021f`; its language
   follows the open decision `D-7` in [`DECISIONS.md`](DECISIONS.md)? (Moved from `tooling/` to
   `tools/`, with English file names.)
5. Public metadata (`CITATION.cff`, `zenodo.json`, `zenodo.files.json`) describe a French
   specification: English only, or English with the French title kept as a proper name?
6. ~~French file names: rename, or keep the names?~~ Decided 2026-10-19: file names are in English;
   the renaming (with the coupled script and test changes) is a follow-up. Open: does it include
   the module file names under `spec/`?
7. While a document is still French, may an English paragraph be added to it, or is the file
   translated first?
