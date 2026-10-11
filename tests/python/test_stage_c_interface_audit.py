# SPDX-FileCopyrightText: 2026 K7PL contributors
#
# SPDX-License-Identifier: CC0-1.0
"""Structural consistency checks for the non-normative Stage C interface audit.

These checks detect drift between the audit register and the current Verso source.
They are not formal proofs of K7PL's mathematical claims or a ratification of candidates.
"""

from __future__ import annotations

from fractions import Fraction
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
C2 = ROOT / "spec" / "Spec" / "C2" / "ComonadeExponentielleEtFragments.lean"
C3 = ROOT / "spec" / "Spec" / "C3" / "LeSystemeGradue.lean"
TYPING = ROOT / "spec" / "Spec" / "C3" / "ReglesDeTypage.lean"
REGISTER = ROOT / "docs" / "migration" / "L1-THEORY-OBJECTS.md"
AUDIT = ROOT / "docs" / "migration" / "L1-C01-C02-TYPED-INTERFACE-AUDIT-2026-10-11.md"


def test_audit_pins_the_source_revision_and_keeps_stage_c_open():
    audit = AUDIT.read_text(encoding="utf-8")
    register = REGISTER.read_text(encoding="utf-8")

    assert "232eb9afca0fdd7d87d2250eceaeeb8a381b271c" in audit
    assert "819385958b3b2fbdada7418d7e7a1f340ff59baf" in audit
    assert "b579261957ce5a2967f736203682ca5c61482eaf" in audit
    assert "11abe4803e93a13a2d24c847dad323337094502f" in audit
    assert "C-01 : PARTIEL, porte ouverte" in audit
    assert "C-02 : PARTIEL, porte ouverte" in audit
    assert "Porte C globale : NON SATISFAITE" in audit
    assert "**État :** IN PROGRESS" in register
    assert "NON SATISFAITE" in register


def test_candidate_index_and_scaling_signatures_remain_explicit_in_c2():
    source = C2.read_text(encoding="utf-8")

    assert r"\pi_U : \mathcal{G}\to\mathcal{R}" in source
    assert r"\pi_U(\langle u,m,\ell,\beta\rangle)=u" in source
    assert r"\operatorname{Bang}_{\mathcal G}(r,A)" in source
    assert r"\operatorname{Scale}_{\mathrm{Usage}}(a,\langle u,m,\ell,\beta\rangle)" in source
    assert "candidat d'architecture" in source


def test_subtyping_direction_is_read_from_the_source_equation():
    source = TYPING.read_text(encoding="utf-8")

    assert r"r \preccurlyeq r' \;\Longleftrightarrow\;" in source
    assert r"u \geq u' \;\land\; m \succeq m' \;\land\; \ell \leq \ell'" in source
    assert r"\beta \leq \beta'" in source
    audit = AUDIT.read_text(encoding="utf-8")
    assert "π_U(r)≥π_U(r′)" in audit


def test_mode_triples_and_proposition_are_not_silently_promoted():
    source = C3.read_text(encoding="utf-8")

    assert r"M_{\mathrm{Lin}} &= (\mathcal{R},\{0\},\mathrm{false})" in source
    assert r"M_{\mathrm{Aff}} &= (\mathcal{R},\{0\},\mathrm{true})" in source
    assert r"M_{\mathrm{Rel}} &= (\mathcal{R},\mathcal{R},\mathrm{false})" in source
    assert r"M_{\mathrm{Unr}} &= (\mathcal{R},\mathcal{R},\mathrm{true})" in source
    statement = source.split('label := "thm:morphismes_modes"', maxsplit=1)[1].split("::::", maxsplit=1)[0]
    assert 'state := "under-review"' in statement
    assert 'evidence := "proofsketch"' in statement


def test_candidate_mode_arrows_follow_only_the_stated_conditional_contract():
    # Minimal model of the proof-sketch conditions:
    # Cont(source) must be included in Cont(target), and Weak must be preserved.
    # "all" denotes R; "zero" denotes {0}. This tests that conditional calculation,
    # not the external theory's full definition or its realization by K7PL's rules.
    modes = {
        "Lin": ("zero", False),
        "Aff": ("zero", True),
        "Rel": ("all", False),
        "Unr": ("all", True),
    }

    def cont_included(source: str, target: str) -> bool:
        source_cont = modes[source][0]
        target_cont = modes[target][0]
        return source_cont == "zero" or target_cont == "all"

    def candidate_morphism(source: str, target: str) -> bool:
        source_weak = modes[source][1]
        target_weak = modes[target][1]
        return cont_included(source, target) and (not source_weak or target_weak)

    assert candidate_morphism("Lin", "Aff")
    assert candidate_morphism("Lin", "Rel")
    assert candidate_morphism("Aff", "Unr")
    assert candidate_morphism("Rel", "Unr")
    assert not candidate_morphism("Aff", "Rel")  # Weak: true does not map to false.
    assert not candidate_morphism("Rel", "Aff")  # 1 in R is not in {0}.


def test_interval_counterexamples_rule_out_inherited_grade_algebras():
    source = C3.read_text(encoding="utf-8")
    assert r"U_{\mathrm{Lin}}=[1..1]" in source
    assert r"U_{\mathrm{Aff}}=[0..1]" in source
    assert r"U_{\mathrm{Rel}}=[1..\omega]" in source
    assert r"U_{\mathrm{Unr}}=[0..\omega]" in source

    one = Fraction(1)
    two = one + one
    assert two == Fraction(2)
    assert two not in {one}  # Lin = [1, 1] is not closed under addition.
    assert two > one  # Aff = [0, 1] is not closed under addition.
    assert Fraction(0) < one  # Rel = [1, omega] excludes the additive zero.

    audit = AUDIT.read_text(encoding="utf-8")
    assert "1+1=2" in audit
    assert "ne contient pas le neutre additif" in audit
