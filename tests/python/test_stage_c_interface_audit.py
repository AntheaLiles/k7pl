# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CC0-1.0
"""Structural consistency checks for the former Stage C interface audit.

The audit and the theory-object register lived in docs/migration/ until the
complete migration closing of 2026-10-25 deleted them; their verdicts are
traced in wiki/_migration-matrix.md and survive in git history. The checks
below therefore read only the current Verso source and the wiki assurance
page. They are not formal proofs of K7PL's mathematical claims.
Reference-interface ratification is distinct from proof of the interface laws.
"""

from __future__ import annotations

from fractions import Fraction
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[2]
C2 = ROOT / "spec" / "Spec" / "C2" / "ExponentialComonadAndFragments.lean"
C3 = ROOT / "spec" / "Spec" / "C3" / "GradedSystem.lean"
TYPING = ROOT / "spec" / "Spec" / "C3" / "TypingRules.lean"
ASSURANCE = ROOT / "wiki" / "assurance.md"


def test_historical_audit_is_pinned_and_current_integration_keeps_stage_c_open():
    # The 12 October source integration intentionally supersedes the files
    # inspected by the 11 October audit; keep the snapshot traceable without
    # treating the old state as the live tree.
    # Non-normative `:::note` slots added while integrating the C8 semantic audit notes also
    # move these pins; the interface strings checked below are unchanged by those notes.
    # So does the B-01 alignment of proof vocabulary (2026-10-19), which rewords status claims
    # in GradedSystem.lean and TypingRules.lean without touching those strings.
    # So do its extension (2026-10-20: « fibrille » for an execution unit in GradedSystem.lean)
    # and the owner's « cofibre » -> « _cofree_ » fix in ExponentialComonadAndFragments.lean.
    # 2026-10-23: prohibited-vocabulary wording cleanup in GradedSystem.lean; audit claims are unchanged.
    # 2026-10-24: the Layer-3 parallelism statement records explicit depth profiles and purity;
    # its corrected Verso math delimiters and source-integrity pin are kept synchronized here.
    # 2026-10-22: the fig:fragments-emboites alternative text/description was narrowed to its
    # structural-rule scope; formal interface strings are independently checked below.
    # 2026-10-25 (migration closing): three pins are re-synced to their
    # current HEAD blobs after the spec rewordings above — GradedSystem.lean
    # (a58598531b331fd843975bf65e6e330bebb3e8d2, replacing 1d6849a5b1b8d0747b3c70ac53ec13e02d7ffbb7),
    # TypeGrammar.lean (08cdf667032f7377ec8eb1719efe3bfe4862a567, replacing
    # 60df0208198163e9bf76dea24391e29d1f23834f) and TypingRules.lean
    # (74541a39b3d94c902ab7809697e665aef1ba93b9, replacing ac11edad16bec18a96126371a624977e0659416b);
    # the interface-string checks below still pass, so this is a pin re-sync,
    # not a ratification of any changed content. In particular it does not
    # ratify the Nxt/Loc rule-inventory drift, which the substitution
    # inventory test still reports as a failure pending review.
    # 2026-10-27: the author's choices Q-TYP-001 and Q-TYP-002 rewrite the formulas of the
    # metalanguage and the type notations of the theory prose from code spans to math spans
    # (e.g. `M_Lin = (𝓡, {0}, false)` becomes $`M_{\mathrm{Lin}} = (\mathcal{R}, \{0\}, \mathrm{false})`).
    # Four pins are re-synced: ExponentialComonadAndFragments.lean (25ea45a9…, replacing
    # 1080a623…), GradedSystem.lean (bd6d774c…, replacing a5859853…), TypeGrammar.lean
    # (08f3d573…, replacing 08cdf667…) and TypingRules.lean (4f83a512…, replacing 74541a39…).
    # The interface strings below are checked in their new notation; a pin re-sync, not a
    # ratification of any changed content.
    # 2026-10-27 (owner request): the module files of spec/ get English names, used throughout
    # these notes; three blobs are unchanged. GradedSystem.lean is re-synced (fc7b98ac…,
    # replacing bd6d774c…): its changes only name the renamed check script
    # (scripts/check_spec.py) and the renamed figure asset (contraction-weakening-matrix).
    # A pin re-sync, not a ratification of any changed content.
    integrated_source_blobs = {
        "spec/Spec/C2/ExponentialComonadAndFragments.lean": "25ea45a9aeb423505302ae4016af552bd3db4955",
        "spec/Spec/C3/GradedSystem.lean": "fc7b98ac9b6ff2bd01ed1378b5120c213675a2b4",
        "spec/Spec/C3/TypeGrammar.lean": "08f3d573323e6f3411fb51897ef000362b81b822",
        "spec/Spec/C3/TypingRules.lean": "4f83a5129ed1b764d1db487d389290a761ff0612",
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
    # The gate verdict itself now lives in the wiki, not in the deleted register.
    assert "not satisfied" in ASSURANCE.read_text(encoding="utf-8")


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


def test_reference_modes_are_selected_but_their_proposition_remains_unproved():
    source = C3.read_text(encoding="utf-8")

    # Math spans since 2026-10-27 (Q-TYP-002); the triples themselves are unchanged.
    assert r"M_{\mathrm{Lin}} = (\mathcal{R}, \{0\}, \mathrm{false})" in source
    assert r"M_{\mathrm{Aff}} = (\mathcal{R}, \{0\}, \mathrm{true})" in source
    assert r"M_{\mathrm{Unr}} = (\mathcal{R}, \mathcal{R}, \mathrm{true})" in source
    assert r"M_{\mathrm{Rel}} = (\mathcal{R}, \mathcal{R}, \mathrm{false})" in source
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
