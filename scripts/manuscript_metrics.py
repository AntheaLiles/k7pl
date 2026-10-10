# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Measures the specification from its Verso sources (`spec/`).

    python3 scripts/manuscript_metrics.py summary     # counts, as Markdown
    python3 scripts/manuscript_metrics.py statements  # register of the numbered statements
    python3 scripts/manuscript_metrics.py json        # everything, as JSON

The counts are *produced from the sources*, never typed by hand: this replaces the "produced
counts" of the former Org tooling. The scan is textual (the directives the converter emits), so it
needs no Lean toolchain.
"""

from __future__ import annotations

import json
import re
import sys
from collections import Counter
from dataclasses import dataclass, field
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SPEC = ROOT / "spec"

INCLUDE = re.compile(r"^\{include \d+ Spec\.([\w.]+)\}", re.M)
DOC = re.compile(r'^#doc \(Manual\) "(.*)" =>', re.M)
HEAD = re.compile(r"^(#+) (.*)$", re.M)
THM = re.compile(r"^::::(thm|definition|axiom|postulate|hypothesis|theorem|lemma|corollary|proposition|conjecture|requirement|literature|example|counterexample)(.*)$", re.M)
ARG = re.compile(r'\((\w+) := "([^"]*)"\)')
NUM = re.compile(r'\{num "([^"]+)"\}')


@dataclass
class Module:
    name: str
    path: Path
    title: str
    text: str
    includes: list[str] = field(default_factory=list)


def load(name: str) -> Module:
    path = SPEC / "Spec" / (name.replace(".", "/") + ".lean") if name != "" else SPEC / "Spec.lean"
    text = path.read_text(encoding="utf-8")
    m = DOC.search(text)
    return Module(name, path, m.group(1) if m else name, text, INCLUDE.findall(text))


def walk(name: str = "", number: str = "", depth: int = 0, out: list | None = None):
    """Modules in document order, with their section number (`3.2`, `A.1`)."""
    out = [] if out is None else out
    mod = load(name)
    out.append((mod, number))
    chapter = appendix = 0
    for i, inc in enumerate(mod.includes, 1):
        if depth == 0:
            if inc.startswith("Annexe"):
                n = "ABCDEFGH"[appendix]
                appendix += 1
            else:
                chapter += 1
                n = str(chapter)
        else:
            n = f"{number}.{i}"
        walk(inc, n, depth + 1, out)
    return out


def args_of(line: str) -> dict[str, str]:
    return dict(ARG.findall(line))


def statements() -> list[dict]:
    """Inventory legacy and ontology-aware statement directives in document order."""
    rows = []
    counter = 0
    directive_kinds = {
        "definition": "definition", "axiom": "assumption", "postulate": "assumption",
        "hypothesis": "assumption", "theorem": "result", "lemma": "result",
        "corollary": "result", "proposition": "result", "conjecture": "result",
        "requirement": "requirement", "literature": "literature", "example": "example",
        "counterexample": "counterexample",
    }
    for mod, number in walk():
        for m in THM.finditer(mod.text):
            counter += 1
            directive, argline = m.group(1), m.group(2)
            a = args_of(argline)
            close = mod.text.find("\\n::::\\n", m.end())
            block = mod.text[m.end(): close if close >= 0 else len(mod.text)]
            title = re.search(r"^:::title\\n(.*?)\\n:::", block, re.S | re.M)
            stmt = re.search(r"^:::statement[^\\n]*\\n(.*?)\\n:::", block, re.S | re.M)
            stmt_title = stmt.group(1).split("\\n", 1)[0] if stmt and "+titled" in mod.text[m.end():m.end() + 400] else ""
            legacy = directive == "thm"
            kind = ({"definition": "definition", "exigence": "requirement", "litterature": "literature"}.get(a.get("status", "theoreme"), "result")
                    if legacy else directive_kinds[directive])
            role = ({"conjecture": "conjecture", "proposition": "proposition"}.get(a.get("status", "theoreme"), "theorem")
                    if legacy and kind == "result" else
                    (a.get("role") or (directive if directive in {"theorem", "lemma", "corollary", "proposition", "conjecture", "axiom", "postulate", "hypothesis"} else "")))
            state = ({"conjecture": "proposed", "proposition": "under-review"}.get(a.get("status", "theoreme"), "under-review")
                     if legacy and kind == "result" else
                     (a.get("state") or ("proposed" if directive == "conjecture" else
                      "not-applicable" if kind not in {"result", "assumption"} else "under-review")))
            rows.append({
                "numero": counter, "label": a.get("label", ""),
                "statut": a.get("status", "theoreme") if legacy else (role or kind),
                "niveau": a.get("level", "langage"),
                "titre": " ".join(title.group(1).split()) if title else "",
                "enonce": " ".join(stmt_title.split()), "module": mod.name, "section": number,
                "esquisse": ":::proofsketch" in block, "directive": directive,
                "kind": kind, "role": role, "state": state,
                "evidence": a.get("evidence", "proofsketch" if legacy and kind == "result" else "none"),
                "scope": a.get("scope", "legacy-unspecified" if legacy else ""),
                "source": a.get("source", ""), "formalArtifact": a.get("formalArtifact", ""),
                "legacy": legacy,
            })
    cited = Counter()
    for mod, _ in walk():
        for lab in NUM.findall(mod.text):
            cited[lab] += 1
    for r in rows:
        r["renvois"] = cited.get(r["label"], 0)
    return rows


def summary() -> dict:
    mods = walk()
    chapters = [(m, n) for m, n in mods if m.name and "." not in m.name]
    sections = [(m, n) for m, n in mods if "." in m.name]
    texts = {m.name: m.text for m, _ in mods}
    count = Counter()
    keys = set()
    labels = set()
    missing = []
    words = 0
    for mod, _ in mods:
        t = mod.text
        for k, pat in {
            "formules": r"^::::formula",
            "figures": r"^::::figure",
            "tableaux": r"^::::k7table",
            "listings": r"^::::listing",
            "remarques_marginales": r"\{rmq\}",
            "citations": r"\{cite ",
            "renvois": r"\{num ",
            "renvois_non_resolus": r"\{missing ",
            "commentaires_conserves": r"^:::comment",
            "notes_de_bas_de_page": r"^\[\^fn\d+\]:",
        }.items():
            count[k] += len(re.findall(pat, t, re.M))
        for ks in re.findall(r'\{cite "([^"]+)"\}', t):
            keys.update(ks.split(","))
        labels.update(re.findall(r'\{label "([^"]+)"', t))
        labels.update(re.findall(r'\(label := "([^"]+)"', t))
        for lab in re.findall(r'\{missing "([^"]+)"\}', t):
            missing.append((mod.name, lab))
        body = re.sub(r"^```.*?^```", "", t, flags=re.S | re.M)
        body = re.sub(r"\$+`[^`]*`", "", body)
        body = "\n".join(l for l in body.split("\n") if not l.startswith(("import ", "open ", "set_option", "--", "%%%", ":::", "::::")))
        words += len(re.findall(r"\w+", body, re.U))
    st = statements()
    by_status = Counter(r["statut"] for r in st)
    by_level = Counter(r["niveau"] for r in st)
    return {
        "chapitres": [{"numero": n, "titre": m.title, "module": m.name, "sections": len(m.includes)} for m, n in chapters],
        "modules": len(mods),
        "sections_niveau_2": len(sections),
        "enonces": len(st),
        "enonces_par_statut": dict(by_status),
        "enonces_par_niveau": dict(by_level),
        "enonces_ouverts": sum(by_status[s] for s in ("proposition", "conjecture", "exigence")),
        "enonces_sans_esquisse": [r["label"] for r in st if not r["esquisse"] and r["statut"] not in ("exigence", "definition")],
        **dict(count),
        "cles_citees": len(keys),
        "labels": len(labels),
        "renvois_non_resolus_liste": missing,
        "mots": words,
    }


STATUS_LABELS = {
    "theoreme": "theorem",
    "proposition": "proposition",
    "exigence": "requirement",
    "conjecture": "conjecture",
    "definition": "definition",
    "litterature": "literature",
}
LEVEL_LABELS = {
    "langage": "language",
    "representation": "representation",
    "compilation": "compilation",
    "deploiement": "deployment",
}

def md_summary() -> str:
    s = summary()
    out = ["| Measure | Value |", "|---|---|"]
    out.append(f"| Chapters | {len(s['chapitres'])} (dont {sum(1 for c in s['chapitres'] if c['module'].startswith('Annexe'))} annexes) |")
    out.append(f"| Level-2 sections (modules) | {s['sections_niveau_2']} |")
    st = ", ".join(f"{v} {STATUS_LABELS.get(k, k)}" for k, v in sorted(s["enonces_par_statut"].items(), key=lambda kv: -kv[1]))
    out.append(f"| Statements | {s['enonces']} ({st}) |")
    out.append(f"| Open statements (proposition, conjecture, exigence) | {s['enonces_ouverts']} |")
    lv = ", ".join(f"{v} {LEVEL_LABELS.get(k, k)}" for k, v in sorted(s["enonces_par_niveau"].items(), key=lambda kv: -kv[1]))
    out.append(f"| Statements by level | {lv} |")
    for k, lab in [("formules", "Formulas"), ("figures", "Figures"), ("tableaux", "Tables"), ("listings", "Source listings"),
                   ("remarques_marginales", "Marginal remarks (RMQ)"), ("citations", "Citations"), ("cles_citees", "Cited works"),
                   ("renvois", "Internal references"), ("renvois_non_resolus", "Unresolved references"),
                   ("commentaires_conserves", "Retained author comments (not rendered)"), ("notes_de_bas_de_page", "Footnotes"),
                   ("mots", "Words (approximate; excluding code and formulas)")]:
        out.append(f"| {lab} | {s.get(k, 0)} |")
    return "\n".join(out)


def md_statements() -> str:
    rows = statements()
    out = ["| No. | Label | Status | Level | Title | Section | References |", "|---:|---|---|---|---|---|---:|"]
    for r in rows:
        loc = f"§{r['section']}" if r["section"] else r["module"]
        out.append(f"| {r['numero']} | `{r['label']}` | {STATUS_LABELS.get(r['statut'], r['statut'])} | {LEVEL_LABELS.get(r['niveau'], r['niveau'])} | {r['titre']} | {loc} | {r['renvois']} |")
    return "\n".join(out)


def main() -> int:
    cmd = sys.argv[1] if len(sys.argv) > 1 else "summary"
    if cmd == "summary":
        print(md_summary())
    elif cmd == "statements":
        print(md_statements())
    elif cmd == "json":
        print(json.dumps({"resume": summary(), "enonces": statements()}, ensure_ascii=False, indent=1))
    else:
        print(__doc__)
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
