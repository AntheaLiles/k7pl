# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Tests for `scripts/suivi.py check`: the status table must cover exactly the consolidated cards.

`check()` is the guard that keeps `docs/tracking/fiches-statuts.csv` in lockstep with
`docs/peer-review/pr-02/taches-consolidees.md`. It is exercised here on a synthetic pair (cards +
CSV) so every failure mode — missing row, orphan row, unknown status — is seen failing at least
once; a control never witnessed failing is worth nothing.
"""

from __future__ import annotations

import pytest


CARDS_OK = """\
# Plan consolidé

## 1. Lot BLOQ

### `BLOQ-01` — **✅ **Énoncé pilote** — titre
Prose.

### `BLOQ-02` — Un second titre
Prose.
"""

CSV_OK = """\
id,statut,confiance,preuve,note
BLOQ-01,fermee,haute,,
BLOQ-02,ouverte,,
"""


@pytest.fixture
def suivi(tmp_path, monkeypatch):
    """A `suivi` module wired to a synthetic corpus; returns helpers to mutate and run `check`."""
    import importlib.util

    from pathlib import Path

    root = Path(__file__).resolve().parent.parent.parent
    spec = importlib.util.spec_from_file_location("suivi_under_test", root / "scripts" / "suivi.py")
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)

    docs = tmp_path / "docs"
    (docs / "suivi").mkdir(parents=True)
    cards = docs / "relectures" / "pr-02" / "taches-consolidees.md"
    cards.parent.mkdir(parents=True)
    statuts = docs / "suivi" / "fiches-statuts.csv"

    def write(cards_text: str, csv_text: str) -> None:
        cards.write_text(cards_text, encoding="utf-8")
        statuts.write_text(csv_text, encoding="utf-8")

    write(CARDS_OK, CSV_OK)
    monkeypatch.setattr(mod, "CARDS", cards)
    monkeypatch.setattr(mod, "STATUTS", statuts)

    class Suivi:
        def __init__(self):
            self.mod = mod
            self.write = write

        def check(self):
            return mod.check()

        def mutate_cards(self, text):
            cards.write_text(text, encoding="utf-8")

        def mutate_csv(self, text):
            statuts.write_text(text, encoding="utf-8")

    return Suivi()


def test_check_passes_on_a_consistent_corpus(suivi):
    assert suivi.check() == 0


def test_card_without_status_row_is_caught(suivi, capsys):
    suivi.mutate_csv("id,statut,confiance,preuve,note\nBLOQ-01,fermee,haute,,\n")
    assert suivi.check() == 1
    assert "fiche sans statut : BLOQ-02" in capsys.readouterr().out


def test_orphan_status_row_is_caught(suivi, capsys):
    suivi.mutate_csv(CSV_OK + "GHOST-01,ouverte,,,\n")
    assert suivi.check() == 1
    assert "statut sans fiche : GHOST-01" in capsys.readouterr().out


def test_unknown_status_value_is_caught(suivi, capsys):
    suivi.mutate_csv("id,statut,confiance,preuve,note\nBLOQ-01,froisseee,haute,,\nBLOQ-02,ouverte,,\n")
    assert suivi.check() == 1
    out = capsys.readouterr().out
    assert "statut inconnu pour BLOQ-01" in out


def test_titles_are_normalised(suivi):
    """The card parser strips the ✅/⚠️ emoji prefixes so titles compare cleanly downstream."""
    titles = suivi.mod.cards()
    assert set(titles) == {"BLOQ-01", "BLOQ-02"}
    assert not titles["BLOQ-01"].startswith(("✅", "⚠️"))
