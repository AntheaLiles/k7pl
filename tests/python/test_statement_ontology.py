# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Focused regression tests for the migrated statement ontology."""

from controles.statement_ontology import violations


def test_legacy_statement_remains_compatible():
    source = '''::::thm (label := "thm:legacy") (status := "theoreme")
:::statement
Existing statement.
:::
:::proofsketch
Existing sketch.
:::
::::'''
    assert violations(source) == []


def test_valid_specialized_result():
    source = '''::::lemma (label := "thm:new") (role := "lemma") (state := "under-review") (evidence := "proofsketch") (scope := "metatheory")
:::statement
Candidate result.
:::
:::proofsketch
Sketch.
:::
::::'''
    assert violations(source) == []


def test_missing_scope_and_sketch_are_blocking():
    source = '''::::theorem (label := "thm:bad") (state := "under-review") (evidence := "proofsketch")
:::statement
Result without scope or sketch.
:::
::::'''
    errors = violations(source)
    assert any("portée explicite absente" in error for error in errors)
    assert any("slot :::proofsketch absent" in error for error in errors)


def test_conjecture_cannot_be_established():
    source = '''::::conjecture (label := "thm:bad") (state := "established") (scope := "local")
:::statement
Unestablished conjecture.
:::
::::'''
    assert any("conjecture ne peut pas être établie" in error for error in violations(source))


def test_literature_requires_provenance():
    source = '''::::literature (label := "lit:missing-source") (scope := "documentary")
:::statement
External result.
:::
::::'''
    assert any("provenance bibliographique absente" in error for error in violations(source))


def test_unknown_scope_tag_is_blocking():
    source = '''::::lemma (label := "thm:bad-scope") (role := "lemma") (state := "under-review") (evidence := "none") (scope := "free-form scope")
:::statement
A result with an uncontrolled scope.
:::
::::'''
    assert any("identifiant de portée non autorisé" in error for error in violations(source))
