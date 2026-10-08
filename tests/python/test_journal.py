# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

from __future__ import annotations

from controles import journal


def teardown_function():
    journal.failures.clear()
    journal.github = False


def test_explicit_location_emits_source_annotation(capsys):
    journal.github = True
    journal.ko("erreur % sur la source", path="spec/Spec/C3/ReglesDeTypage.lean", line=1598, col=37)
    output = capsys.readouterr().out
    assert "::error file=spec/Spec/C3/ReglesDeTypage.lean,line=1598,col=37,title=controle.py::erreur %25 sur la source" in output


def test_global_failure_stays_in_report_only(capsys):
    journal.github = True
    journal.ko("échec global")
    output = capsys.readouterr().out
    assert "ECHEC  échec global" in output
    assert "::error" not in output


def test_module_line_is_inferred_as_a_source_annotation(patched, capsys):
    journal.github = True
    journal.ko("règle fautive : C2.Fondements:17")
    output = capsys.readouterr().out
    assert "::error file=spec/Spec/C2/Fondements.lean,line=17,title=controle.py::règle fautive : C2.Fondements:17" in output
