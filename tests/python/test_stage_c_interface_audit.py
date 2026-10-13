# SPDX-FileCopyrightText: 2026 K7PL contributors
#
# SPDX-License-Identifier: CC0-1.0
"""Structural consistency checks for the non-normative Stage C interface audit.

These checks detect drift between the historical audit, the current Verso source, and the recorded source integration.
The C3 rules and effective-kernel source pins below are updated when the compiled kernel fragment is extended.
They are not formal proofs of K7PL's mathematical claims. Reference-interface ratification is distinct from proof of the interface laws.
"""

from __future__ import annotations

from fractions import Fraction
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[2]
C2 = ROOT / "spec" / "Spec" / "C2" / "ComonadeExponentielleEtFragments.lean"
C3 = ROOT / "spec" / "Spec" / "C3" / "LeSystemeGradue.lean"
TYPING = ROOT / "spec" / "Spec" / "C3" / "ReglesDeTypage.lean"
REGISTER = ROOT / "docs" / "migration" / "L1-THEORY-OBJECTS.md"
AUDIT = ROOT / "docs" / "migration" / "L1-C01-C02-TYPED-INTERFACE-AUDIT-2026-10-11.md"


def test_historical_audit_is_pinned_and_current_integration_keeps_stage_c_open():
    audit = AUDIT.read_text(encoding="utf-8")
    register = REGISTER.read_text(encoding="utf-8")

    assert "232eb9afca0fdd7d87d2250eceaeeb8a381b271c" in audit
    assert "819385958b3b2fbdada7418d7e7a1f340ff59baf" in audit
    assert "b579261957ce5a2967f736203682ca5c61482eaf" in audit
    assert "11abe4803e93a13a2d24c847dad323337094502f" in audit

    # Historical blobs above pin the snapshot inspected by the 11 October audit.
    # The 12 October source integration intentionally supersedes three of those files;
    # keep the snapshot traceable without treating the old state as the live tree.
    # Non-normative `:::note` slots added while integrating the C8 semantic audit notes also
    # move these pins; the interface strings checked below are unchanged by those notes.
    integrated_source_blobs = {
        "spec/Spec/C2/ComonadeExponentielleEtFragments.lean": "a024ae7fcb82b0ffe555e41a72fead8f9fbbc977",
        "spec/Spec/C3/LeSystemeGradue.lean": "4ba4a66c555c9cfa0a4feee14eb954589567d5b9",
        "spec/Spec/C3/GrammaireDesTypes.lean": "ec28a842c30119590530409cba66a3e60e0b3f2c",
        "spec/Spec/C3/ReglesDeTypage.lean": "8bed92618abac23000af45221718aeb99bf008e5",
        "spec/Spec/C3/EffectiveKernel.lean": "127039c7b93fee5696f2c0b1c81805ba29726bb0",
    }
    for path, expected_blob in integrated_source_blobs.items():
        actual_blob = subprocess.run(
            ["git", "rev-parse", f"HEAD:{path}"],
            cwd=ROOT,
            check=True,
            capture_output=True,
            text=True,
        ).stdout.strip()
        assert actual_blob == expected_blob, f"source changed since audit: {path}"
    assert "C-01 : PARTIEL, porte ouverte" in audit
    assert "C-02 : PARTIEL, porte ouverte" in audit
    assert "Porte C globale : NON SATISFAITE" in audit
    assert "**État :** IN PROGRESS" in register
    assert "NON SATISFAITE" in register


def test_reference_index_and_scaling_signatures_remain_explicit_in_c2():
    source = C2.read_text(encoding="utf-8")

    assert r"\pi_U : \mathcal{G}\to\mathcal{R}" in source
    assert r"\pi_U(\langle u,m,\ell,\beta\rangle)=u" in source
    assert r"\operatorname{Bang}_{\mathcal G}(r,A)" in source
    assert r"\operatorname{Scale}_{\mathrm{Usage}}(a,\langle u,m,\ell,\beta\rangle)" in source
    assert "interface de référence" in source
    assert "ne prouve pas les lois de cohérence de cette instance" in source


def test_subtyping_direction_is_read_from_the_source_equation():
    source = TYPING.read_text(encoding="utf-8")

    assert r"r \preccurlyeq r' \;\Longleftrightarrow\;" in source
    assert r"u \geq u' \;\land\; m \succeq m' \;\land\; \ell \leq \ell'" in source
    assert r"\beta \leq \beta'" in source
    audit = AUDIT.read_text(encoding="utf-8")
    assert "π_U(r)≥π_U(r′)" in audit


def test_reference_modes_are_selected_but_their_proposition_remains_unproved():
    source = C3.read_text(encoding="utf-8")

    assert "M_Lin = (𝓡, {0}, false)" in source
    assert "M_Aff = (𝓡, {0}, true)" in source
    assert "M_Unr = (𝓡, 𝓡, true)" in source
    assert "M_Rel = (𝓡, 𝓡, false)" in source
    assert "n'est pas un mode normatif de la grammaire courante" in source
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
    assert "ne possède pas le neutre additif" in audit
