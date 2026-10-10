# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1
"""Blocking structural checks for the C8 statement ontology.

The parser is deliberately source-oriented: it validates directive metadata and slots,
not the mathematical truth of statements. Legacy ``::::thm`` blocks remain permissive.
"""

from __future__ import annotations

import re

from . import corpus
from .journal import ko, ok

DIRECTIVE_TO_KIND = {
    "definition": "definition", "axiom": "assumption", "postulate": "assumption",
    "hypothesis": "assumption", "theorem": "result", "lemma": "result",
    "corollary": "result", "proposition": "result", "conjecture": "result",
    "requirement": "requirement", "literature": "literature", "example": "example",
    "counterexample": "counterexample",
}
RESULT_ROLES = {"theorem", "lemma", "corollary", "proposition", "conjecture"}
ASSUMPTION_ROLES = {"axiom", "postulate", "hypothesis"}
STATES = {"proposed", "under-review", "supported", "established", "refuted", "withdrawn", "not-applicable"}
EVIDENCE = {"none", "written-proof", "proofsketch", "literature", "computation", "counterexample", "lean-proof"}
SCOPES = {"syntax", "metatheory", "graphs", "resources", "memory-safety", "security", "operational-semantics", "graded-typing", "effects", "logical-relations", "translation", "fixed-points", "interoperability", "concurrency", "ffi-safety", "representation", "compiler-interface", "compilation", "resource-accounting", "literature"}
ARGS = re.compile(r'\((\w+) := "([^"]*)"\)')


def _blocks(text: str):
    """Yield directive name, arguments, body, and source line for each statement block."""
    lines = text.splitlines()
    i = 0
    directive_names = {"thm", *DIRECTIVE_TO_KIND}
    while i < len(lines):
        m = re.match(r"^::::([a-zA-Z]+)(.*)$", lines[i])
        if not m or m.group(1) not in directive_names:
            i += 1
            continue
        start = i
        name, argline = m.group(1), m.group(2)
        i += 1
        body = []
        while i < len(lines) and lines[i].strip() != "::::":
            body.append(lines[i])
            i += 1
        yield name, dict(ARGS.findall(argline)), "\n".join(body), start + 1
        if i < len(lines):
            i += 1


def violations(text: str, module: str = "<source>") -> list[str]:
    """Return mechanically decidable ontology inconsistencies for one source module."""
    errors: list[str] = []
    for name, args, body, line in _blocks(text):
        where = f"{module}:{line}"
        if name == "thm":
            # Compatibility mode: old metadata is inventoried but not retroactively judged.
            continue
        kind = DIRECTIVE_TO_KIND[name]
        role = args.get("role") or (name if name in RESULT_ROLES | ASSUMPTION_ROLES else "")
        state = args.get("state") or ("proposed" if name == "conjecture" else
            "not-applicable" if kind not in {"result", "assumption"} else "under-review")
        evidence = args.get("evidence", "none")
        scope = args.get("scope", "")
        label = args.get("label", "")
        source = args.get("source", "")
        artifact = args.get("formalArtifact", "")
        numbered = name not in {"hypothesis", "example", "counterexample"}

        if state not in STATES:
            errors.append(f"{where}: état épistémique inconnu {state!r}")
        if evidence not in EVIDENCE:
            errors.append(f"{where}: type de preuve inconnu {evidence!r}")
        if not scope or scope == "unspecified":
            errors.append(f"{where}: portée explicite absente")
        elif scope not in SCOPES:
            errors.append(f"{where}: identifiant de portée non autorisé {scope!r}")
        if kind == "result" and (role not in RESULT_ROLES or state == "not-applicable"):
            errors.append(f"{where}: rôle/état incompatible avec un résultat ({role!r}, {state!r})")
        if kind == "assumption" and (role not in ASSUMPTION_ROLES or state == "not-applicable"):
            errors.append(f"{where}: rôle/état incompatible avec une hypothèse/axiome/postulat")
        if kind not in {"result", "assumption"} and state != "not-applicable":
            errors.append(f"{where}: un objet {kind!r} doit avoir state=\"not-applicable\"")
        if role == "conjecture" and state == "established":
            errors.append(f"{where}: une conjecture ne peut pas être établie")
        if (kind == "literature" or evidence == "literature") and not source:
            errors.append(f"{where}: evidence=literature exige source")
        if evidence == "lean-proof" and not artifact:
            errors.append(f"{where}: evidence=lean-proof exige formalArtifact")
        if artifact and evidence != "lean-proof":
            errors.append(f"{where}: formalArtifact exige evidence=lean-proof")
        if evidence in {"proofsketch", "written-proof", "lean-proof"} and kind != "result":
            errors.append(f"{where}: {evidence} n'est admis que pour un résultat")
        if kind == "assumption" and role == "hypothesis" and scope == "global":
            errors.append(f"{where}: une hypothèse doit avoir une portée locale")
        if numbered and not label:
            errors.append(f"{where}: étiquette requise pour cet objet numéroté")
        has_sketch = ":::proofsketch" in body
        if evidence == "proofsketch" and not has_sketch:
            errors.append(f"{where}: evidence=proofsketch mais slot :::proofsketch absent")
        if evidence != "proofsketch" and has_sketch:
            errors.append(f"{where}: slot :::proofsketch présent sans evidence=proofsketch")
    return errors


def run():
    all_errors = []
    for name, _, text in corpus.modules():
        all_errors.extend(violations(text, name))
    if all_errors:
        ko("ontologie des énoncés : " + " ; ".join(all_errors[:8]))
    else:
        ok("ontologie des énoncés : métadonnées, portée, provenance et slots cohérents")
