# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Tests for `scripts/manuscript_metrics.py`: the Verso directive parser and the counters."""

from __future__ import annotations


def test_walk_document_order_and_numbering(patched):
    import manuscript_metrics as mm

    mods = [(m.name, n) for m, n in mm.walk()]
    assert ("C1", "1") in mods
    assert ("C2", "2") in mods
    assert ("C2.Fondements", "2.1") in mods
    # document order: the chapter precedes its section
    numbers = [n for _, n in mods]
    assert numbers.index("2") < numbers.index("2.1")


def test_thm_directive_parsed(patched):
    import manuscript_metrics as mm

    rows = mm.statements()
    assert len(rows) == 1
    r = rows[0]
    assert r["label"] == "thm:exemple"
    assert r["statut"] == "theoreme"          # default seal when no status:= is given… declared here
    assert r["niveau"] == "langage"           # default level
    assert r["titre"] == "exemple de théorème"
    assert r["enonce"].startswith("Enoncé d'exemple")
    assert r["esquisse"] is True
    assert r["section"] == "2.1"


def test_status_change_is_visible_in_the_register(patched):
    """Mutating the seal (status := conjecture) must flow into the register — that is what the
    notation checks rely on to catch an unproven theorem."""
    import manuscript_metrics as mm

    f = patched / "Spec" / "C2" / "Fondements.lean"
    f.write_text(f.read_text(encoding="utf-8").replace('(status := "theoreme")', '(status := "conjecture")'), encoding="utf-8")
    rows = mm.statements()
    assert rows[0]["statut"] == "conjecture"


def test_summary_counts(patched):
    import manuscript_metrics as mm

    s = mm.summary()
    assert s["enonces"] == 1
    # eq:pilote + eq:grammaire-termes (C2.Fondements) + eq:grammaire-types (C2.Algebre)
    assert s["formules"] == 3
    assert s["modules"] >= 3
    assert s["renvois_non_resolus"] == 0
    assert s["mots"] > 0


def test_md_summary_is_a_table(patched):
    import manuscript_metrics as mm

    md = mm.md_summary()
    lines = md.splitlines()
    assert lines[0].startswith("| Measure |")
    assert any("Statements" in l for l in lines)


def test_json_output_is_serialisable(patched, capsys, monkeypatch):
    import json

    import manuscript_metrics as mm

    monkeypatch.setattr(mm.sys, "argv", ["manuscript_metrics.py", "json"])
    assert mm.main() == 0
    payload = json.loads(capsys.readouterr().out)
    assert payload["resume"]["enonces"] == 1
    assert payload["enonces"][0]["label"] == "thm:exemple"


def test_specialized_directive_exposes_ontology_fields(patched):
    import manuscript_metrics as mm

    f = patched / "Spec" / "C2" / "Fondements.lean"
    source = f.read_text(encoding="utf-8")
    source = source.replace(
        '::::thm (label := "thm:exemple") (status := "theoreme")',
        '::::lemma (label := "thm:exemple") (level := "langage") (role := "lemma") '
        '(state := "under-review") (evidence := "proofsketch") (scope := "synthetic test scope")',
    )
    f.write_text(source, encoding="utf-8")
    row = mm.statements()[0]
    assert row["directive"] == "lemma"
    assert row["kind"] == "result"
    assert row["role"] == "lemma"
    assert row["state"] == "under-review"
    assert row["evidence"] == "proofsketch"
    assert row["scope"] == "synthetic test scope"
