# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Tests for `scripts/controles/`: the checks must pass on a clean mini-corpus and FAIL on
mutations. A check that has never been seen failing is worth nothing — every test below is
therefore paired with the mutation it is supposed to catch (auto-tests mutés)."""

from __future__ import annotations

import pytest


from conftest import mutate


def failures_of():
    from controles import journal

    return list(journal.failures)


def has_failure(*needles):
    """At least one recorded failure contains every needle given."""
    return any(all(n in m for n in needles) for m in failures_of())


@pytest.fixture
def struct(patched):
    """Run the structure checks on the (unmutated) mini-corpus once, expose the verdicts."""
    from controles import structure

    structure.run()
    return failures_of()


def test_references_resolve_ok(struct):
    assert not [f for f in struct if "renvois" in f]


def test_unresolved_label_is_caught(patched):
    """Mutation: point {num} at a label that does not exist → structure must fail."""
    from controles import structure

    mutate(patched, "Spec/C2/Fondements.lean", '{num "eq:pilote"}', '{num "eq:fantasme"}')
    structure.references_resolve()
    assert has_failure("étiquette inconnue")


def test_missing_directive_is_caught(patched):
    """Mutation: an explicit `{missing …}` mark → structure must fail."""
    from controles import structure

    mutate(patched, "Spec/C2/Fondements.lean", "{num \"eq:pilote\"}", "{missing \"thm:absent\"}")
    structure.references_resolve()
    assert has_failure("non résolus")


def test_duplicate_label_is_caught(patched):
    """Mutation: two seals sharing one label → uniqueness must fail."""
    from controles import structure

    dup = '\n::::thm (label := "thm:exemple") (status := "proposition")\n:::title\nbis\n:::\n:::statement\nbis\n:::\n::::\n'
    mutate(patched, "Spec/C2/Fondements.lean", "Il y a une règle de typage Var", dup + "Il y a une règle")
    structure.labels_unique_and_prefixed()
    assert has_failure("double")


def test_bad_label_prefix_is_caught(patched):
    """A formula labelled thm:… breaks the prefix convention."""
    from controles import structure

    mutate(patched, "Spec/C2/Fondements.lean", '(label := "eq:pilote")', '(label := "thm:pilote")')
    structure.labels_unique_and_prefixed()
    assert has_failure("préfixe")


def test_hardcoded_appendix_letter_is_caught(patched):
    from controles import structure

    mutate(patched, "Spec/C1.lean", "Le cadre pose", "Voir Annexe B pour le détail.\n\nLe cadre pose")
    structure.appendix_letters()
    assert has_failure("lettre d'annexe")


def test_author_comment_is_caught(patched):
    from controles import structure

    mutate(patched, "Spec/C1.lean", "Le cadre pose", ":::comment\nTODO: clarifier ce point\n:::\n\nLe cadre pose")
    structure.no_author_comments()
    assert has_failure("commentaire")


# ---------------------------------------------------------------- notation (le sceau)


def test_seal_ok_on_clean_corpus(patched):
    from controles import notation

    notation.seal()
    assert not failures_of()


def test_removed_sketch_fails_the_seal(patched):
    """Mutation: withdraw the proof sketch from a theorem → the seal must reject it."""
    from controles import notation

    f = patched / "Spec" / "C2" / "Fondements.lean"
    text = f.read_text(encoding="utf-8").replace(
        ":::proofsketch\nCroquis de preuve.\n:::\n", ""
    )
    f.write_text(text, encoding="utf-8")
    notation.seal()
    assert has_failure("sans esquisse")


def test_undeclared_status_fails_the_seal(patched):
    """A seal carrying an unknown status (lemma) must be rejected."""
    from controles import notation

    f = patched / "Spec" / "C2" / "Fondements.lean"
    f.write_text(f.read_text(encoding="utf-8").replace('(status := "theoreme")', '(status := "lemme")'), encoding="utf-8")
    notation.seal()
    assert has_failure("statut")


def test_exigence_with_sketch_fails(patched):
    """An exigence may not carry a proof sketch."""
    from controles import notation

    f = patched / "Spec" / "C2" / "Fondements.lean"
    f.write_text(f.read_text(encoding="utf-8").replace('(status := "theoreme")', '(status := "exigence")'), encoding="utf-8")
    notation.seal()
    assert has_failure("exigence")


def test_assertive_verb_about_open_statement_is_caught(patched):
    """Mutation: an open statement (conjecture) asserted as established by a mention."""
    from controles import notation

    mutate(patched, "Spec/C2/Fondements.lean", '(status := "theoreme")', '(status := "conjecture")')
    # move the citing sentence into the same module: {num thm:…}[] « établit » within 90 chars
    mutate(patched, "Spec/C2/Fondements.lean",
           "La loi d'action est le",
           "Le lemme {num \"thm:exemple\"}[] établit le résultat fondamental. La loi d'action est le")
    notation.propagated_mentions()
    assert has_failure("énoncé ouvert dit acquis"), failures_of()


# ---------------------------------------------------------------- algebre (auto-test muté)


def test_algebra_selftest_passes():
    """The built-in mutation self-test of the action law must itself pass."""
    from controles import algebre

    algebre.selftest()
    assert not failures_of()


@pytest.mark.parametrize("minus,expected", [("minus_residue", 10), ("minus_truncated", 14)])
def test_action_law_counterexamples(minus, expected):
    from controles import algebre

    assert len(algebre.counterexamples(getattr(algebre, minus))) == expected


def test_restricted_truncated_subtraction_is_clean():
    from controles import algebre

    assert algebre.counterexamples(algebre.minus_truncated, restricted=True) == []


def test_action_law_without_restriction_is_caught(patched):
    """Mutation: drop the finiteness restriction → the bound check must fail."""
    from controles import algebre

    mutate(patched, "Spec/C2/Fondements.lean",
           "restreinte aux usages finis ($`u \\neq \\omega`$)", "(sans restriction)")
    algebre.action_law_at_the_bounds()
    assert has_failure("loi d'action") or has_failure("FAUSSE") or has_failure("sans restriction")


def test_missing_infinity_convention_is_caught(patched):
    """Mutation: erase ω·ω from the conventions of ℕ∞."""
    from controles import algebre

    mutate(patched, "Spec/C2/Fondements.lean", "$`\\omega \\cdot \\omega`$", "$`k \\cdot k`$")
    algebre.conventions_of_infinity()
    assert has_failure("jamais écrite", "ω · ω")


def test_size_sorts_are_checked(patched):
    """Mutation: let 𝕊_μ keep ω — a size-ω fold would not terminate."""
    from controles import algebre

    mutate(patched, "Spec/C2/Fondements.lean",
           "$`\\mathbb{S}_\\mu \\;=\\; \\mathbb{N}_\\infty \\setminus \\{\\omega\\}`$", "$`\\mathbb{S}_\\mu \\;=\\; \\mathbb{N}_\\infty`$")
    algebre.size_sorts_inhabited()
    assert has_failure("n'exclut pas ω")


# ---------------------------------------------------------------- croise


def test_croise_selftest_passes():
    from controles import croise

    croise.selftest()
    assert not failures_of()


def test_unknown_typing_rule_is_declared_or_fails(patched, primitives):
    """A rule absent from the EXPECTED table must surface as a failure (no silent coverage)."""
    from controles import croise

    mutate(patched, "Spec/C2/Fondements.lean", "La règle Var conclut",
           "\\textsc{Fantome}\\;\\frac{\\;\\Delta \\vdash t : T\\;}{\\;\\Delta \\vdash t : T\\;}\n\nLa règle Var conclut")
    croise.run()
    assert has_failure("Fantome"), "une règle non déclarée dans le tableau doit être signalée"


# ---------------------------------------------------------------- couverture


def test_couverture_run_on_repo():
    """The coverage matrix must compute on the real corpus without malformed anchors."""
    from controles import couverture

    couverture.run()
    assert not failures_of()


def test_couverture_matrix_counts(tmp_path, monkeypatch):
    """Unit-level: lean_units finds namespaces and declarations; malformed anchors are reported."""
    import re

    from controles import couverture

    src = tmp_path / "src"
    (src / "K7pl").mkdir(parents=True)
    (src / "K7pl" / "Algebre.lean").write_text(
        "namespace K7pl.Algebre\n\n-- Formule eq:pilote := add_le_add\ntheorem add_le_add : True := trivial\n\nend K7pl.Algebre\n",
        encoding="utf-8",
    )
    monkeypatch.setattr(couverture, "SRC", src)
    units = dict(couverture.lean_units())
    assert "K7pl.Algebre" in units
    assert re.findall(r"theorem\s+([\w.']+)", units["K7pl.Algebre"]) == ["add_le_add"]
    body = couverture._strip_comment_markers(units["K7pl.Algebre"])
    assert couverture.ANCHOR_FORMULA.findall(body) == [("eq:pilote", "add_le_add")]


def test_couverture_anchor_grammar_matches_midline(tmp_path, monkeypatch):
    """Regression (auto-critique): the anchors must be found on ANY line of a namespace body.

    Without `re.M`, `^` matches only at offset 0: every anchor sitting after the first line is
    silently skipped and the matrix reads 0 % coverage with no error — exactly the failure mode
    this control exists to prevent elsewhere. The three anchor grammars are exercised here on a
    file whose anchors all sit deep inside the namespace body.
    """
    from controles import couverture

    src = tmp_path / "src"
    (src / "K7pl").mkdir(parents=True)
    (src / "K7pl" / "Algebre.lean").write_text(
        "namespace K7pl.Algebre\n\n"
        "-- some prose first line\n"
        "-- more prose second line\n\n"
        "def Var : Type := Nat\n\n"
        "theorem add_le_add : True := trivial\n\n"
        "-- Formule eq:pilote := add_le_add\n"
        "-- Énoncé thm:exemple := add_le_add\n"
        "-- Regle Var := Var\n\n"
        "end K7pl.Algebre\n",
        encoding="utf-8",
    )
    monkeypatch.setattr(couverture, "SRC", src)
    g = couverture.scan()
    assert g["anchored_formulas"] == {"eq:pilote"}, "l'accroche Formule doit être vue hors première ligne"
    assert g["anchored_statements"] == {"thm:exemple"}, "l'accroche Énoncé doit être vue hors première ligne"
    assert g["covered_rules"] == {"Var"}, "l'accroche Regle doit être vue hors première ligne (regex sans re.M)"
    assert g["malformed"] == []


def test_couverture_statement_anchor_covers_normative_label(tmp_path, monkeypatch):
    """A statement anchor must actually contribute to the corresponding normative coverage."""
    from controles import couverture

    src = tmp_path / "src"
    (src / "K7pl").mkdir(parents=True)
    (src / "K7pl" / "Algebre.lean").write_text(
        "namespace K7pl.Algebre\n\n"
        "-- Énoncé thm:exemple := add_le_add\n"
        "-- Énoncé thm:exigence := add_le_add\n"
        "theorem add_le_add : True := trivial\n\n"
        "end K7pl.Algebre\n",
        encoding="utf-8",
    )
    monkeypatch.setattr(couverture, "SRC", src)
    monkeypatch.setattr(couverture, "normative_ids", lambda: (
        [{"label": "thm:exemple", "kind": "result", "role": "theorem"},
         {"label": "thm:exigence", "kind": "requirement", "role": ""},
         {"label": "thm:conj", "kind": "result", "role": "conjecture"}],
        {"formules": [], "regles": []},
    ))
    table, stats = couverture.matrix()
    assert stats["theoremes_couverts"] == 1
    assert stats["ouverts_couverts"] == 1
    assert "| Énoncés `theorem`, `lemma`, `corollary`, `proposition` | 1 | 1 | 100 % |" in table
    assert "| Énoncés `conjecture` et exigences (`requirement`) | 2 | 1 | 50 % |" in table


def _statement_block(directive: str, label: str) -> str:
    """One C8 statement block, as `manuscript_metrics.statements()` parses it."""
    return f'::::{directive} (label := "{label}")\n:::title\n{label}\n:::\n:::statement\nx\n:::\n::::\n\n'


def test_couverture_families_follow_c8_fields_on_mini_corpus(patched):
    """Regression: the statement families are selected on the C8 `kind`/`role`, not on `statut`.

    Since the C8 directive migration `manuscript_metrics.statements()` fills `statut` with
    `role or kind`. A matrix still filtering on the legacy values (`theoreme`, `exigence`) misses
    every `::::theorem`/`::::lemma`/`::::corollary` and every requirement. Expected counts are
    written by hand: the legacy `thm:exemple` seal (role `theorem`) plus one block per C8
    directive; definitions and literature belong to neither family. The families follow the
    ratified C8 result roles (theorem, lemma, corollary, proposition vs conjecture).
    """
    from controles import couverture

    blocks = "".join(_statement_block(d, lab) for d, lab in [
        ("theorem", "thm:t"), ("lemma", "thm:l"), ("corollary", "thm:c"),
        ("proposition", "thm:p"), ("conjecture", "thm:j"), ("requirement", "req:r"),
        ("definition", "def:d"), ("literature", "thm:lit"),
    ])
    marker = "Il y a une règle de typage Var"
    mutate(patched, "Spec/C2/Fondements.lean", marker, blocks + marker)
    table, stats = couverture.matrix()
    assert stats["theoremes"] == 5, "theorem, lemma, corollary, proposition and the legacy theorem seal"
    assert stats["ouverts"] == 2, "the conjecture and the requirement"
    assert stats["hors_familles"] == 2, "definition and literature belong to neither family"
    assert "| Énoncés `theorem`, `lemma`, `corollary`, `proposition` | 5 | 0 | 0 % |" in table
    assert "| Énoncés `conjecture` et exigences (`requirement`) | 2 | 0 | 0 % |" in table


def test_couverture_families_follow_c8_fields_on_real_spec(real_lean):
    """Regression on the real `spec/`: theorem-like statements and requirements are all counted.

    Before the fix the published block read « Énoncés `theoreme` … 0 » and left the
    requirements out, although the specification carries dozens of theorem-like statements.
    Families (decision recorded in `couverture.py`, after the ratified C8 result roles):
    theorem-like = result with role `theorem`, `lemma`, `corollary` or `proposition`; the other
    family = result with role `conjecture`, plus every requirement; the remaining kinds
    (definition, literature…) are in neither. The epistemic `state` plays no part.
    """
    import manuscript_metrics as mm

    rows = mm.statements()
    theorem_like = [r for r in rows if r["kind"] == "result"
                    and r["role"] in {"theorem", "lemma", "corollary", "proposition"}]
    requirements = [r for r in rows if r["kind"] == "requirement"]
    conjectures = [r for r in rows if r["kind"] == "result" and r["role"] == "conjecture"]
    assert theorem_like and requirements, "the real spec/ carries theorem-like statements and requirements"
    _, stats = real_lean.matrix()
    assert stats["theoremes"] == len(theorem_like)
    assert stats["ouverts"] == len(conjectures) + len(requirements)
    assert stats["theoremes"] + stats["ouverts"] + stats["hors_familles"] == len(rows), \
        "every registered statement is either in a family or explicitly outside both"


def test_couverture_rule_anchor_counts_as_declared_link(tmp_path, monkeypatch):
    """A `Regle` anchor alone is a declared link: the block must not claim that none exists."""
    from controles import couverture

    src = tmp_path / "src"
    (src / "K7pl").mkdir(parents=True)
    (src / "K7pl" / "Algebre.lean").write_text(
        "namespace K7pl.Algebre\n\n-- Regle Var := Var\ndef Var : Type := Nat\n\nend K7pl.Algebre\n",
        encoding="utf-8",
    )
    monkeypatch.setattr(couverture, "SRC", src)
    monkeypatch.setattr(couverture, "normative_ids", lambda: ([], {"formules": [], "regles": ["Var"]}))
    _, stats = couverture.matrix()
    assert stats["regles_couverts"] == 1
    assert stats["accroches"] == 1
    assert "Aucun lien n'est encore déclaré" not in couverture.render_block()


def test_couverture_malformed_anchor_is_caught(tmp_path, monkeypatch):
    """An anchor naming a nonexistent lemma is an error, never silence."""
    from controles import couverture

    src = tmp_path / "src"
    (src / "K7pl").mkdir(parents=True)
    (src / "K7pl" / "Algebre.lean").write_text(
        "namespace K7pl.Algebre\n\n"
        "theorem reel_existe : True := trivial\n\n"
        "-- Formule eq:fantome := lemme_inexistant\n\n"
        "end K7pl.Algebre\n",
        encoding="utf-8",
    )
    monkeypatch.setattr(couverture, "SRC", src)
    g = couverture.scan()
    assert any("lemme_inexistant" in m for m in g["malformed"]), \
        "une accroche qui cite un lemme absent de src/ doit être signalée comme mal formée"


def test_couverture_scan_on_real_src(real_lean):
    """End-to-end on the real `src/`: namespaces and declarations must be parsed, not just synthesized.

    The unit tests above use hand-written Lean; only this test proves `lean_units()` actually
    understands the repository's files (imports, attributes, nested namespaces). If it ever
    returns nothing usable, every anchor would silently miss its target and coverage would read
    a false 0 % — the exact failure mode of the `re.M` bug this suite was born from.
    """
    units = real_lean.lean_units()
    assert units, "src/ ne contient aucun module explorable"
    all_decls = {name for _, code in units for name in real_lean.DECL.findall(code)}
    assert all_decls, "aucune déclaration theorem/lemma/def reconnue dans le vrai src/"
    # whatever the current coverage is, scanning the real sources must not report malformed anchors
    g = real_lean.scan()
    assert g["malformed"] == []


# ---------------------------------------------------------------- vocabulary policy

@pytest.mark.parametrize(
    "term",
    [
        "viol",
        "viols",
        "violer",
        "viole",
        "violons",
        "violais",
        "violait",
        "violions",
        "violiez",
        "violaient",
        "violai",
        "violâmes",
        "violèrent",
        "violerai",
        "violerait",
        "violasse",
        "violassent",
        "violé",
        "violée",
        "violés",
        "violées",
        "violation",
        "violations",
        "violence",
        "violences",
        "violent",
        "violente",
        "violents",
        "violentes",
        "violemment",
        "violenté",
        "violentée",
        "violeur",
        "violeuse",
        "violateur",
        "violatrice",
        "violable",
        "violabilité",
        "inviolable",
        "inviolabilité",
        "inviolablement",
    ],
)
def test_prohibited_lexical_family_is_detected(term):
    from controles import vocabulaire

    findings = vocabulaire.find_forbidden_terms(f"Contexte : {term}.")
    assert [finding.term.lower() for finding in findings] == [term.lower()]


def test_unrelated_words_with_overlapping_letters_are_allowed():
    from controles import vocabulaire

    assert vocabulaire.find_forbidden_terms("Le marqueur violet est visible.") == []
    assert vocabulaire.find_forbidden_terms("Le violon reste un exemple distinct.") == []


def test_vocabulary_scan_reports_source_location_and_ignores_unrelated_words(tmp_path):
    from controles import vocabulaire

    spec_root = tmp_path / "spec"
    source = spec_root / "Spec" / "Example.lean"
    source.parent.mkdir(parents=True)
    source.write_text(
        "Le disque violet est visible.\\nUne violation du contrat est décrite.\\n",
        encoding="utf-8",
    )

    findings = vocabulaire.scan(spec_root)
    assert len(findings) == 1
    assert findings[0].path == source
    assert findings[0].term.lower() == "violation"
    assert findings[0].line == 2
    assert findings[0].column == len("Une violation du contrat est décrite.") - len("violation") + 1

