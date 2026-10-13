#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1
"""Extract selected K7PL tactic proofs through Paperproof and emit static HTML/JSON."""

from __future__ import annotations

import argparse
import hashlib
import html
import json
import re
import subprocess
import tempfile
from pathlib import Path
from typing import Any

PAPERPROOF_REVISION = "05c68e9cb8e881f9e971abb94efd231a269e0229"
PAPERPROOF_TOOLCHAIN = "leanprover/lean4:v4.29.0-rc8"
SCHEMA_VERSION = "k7pl.proof-visualization/v1"
REPOSITORY_URL = "https://github.com/AntheaLiles/k7pl"
TARGETS = (
    {
        "slug": "eval-double",
        "title": "Conservation sémantique de double",
        "source": "src/K7pl/Arith.lean",
        "declaration": "K7pl.Arith.eval_double",
        "description": "Preuve arithmétique : simplification puis normalisation par ring.",
    },
    {
        "slug": "scale-usage-comp",
        "title": "Composition de Scale_Usage",
        "source": "src/K7pl/UsageScale.lean",
        "declaration": "K7pl.UsageScale.scaleUsage_comp",
        "description": "Analyse de cas sur le grade puis simplification algébrique.",
    },
    {
        "slug": "project-usage-context-scale",
        "title": "Projection d’usage et mise à l’échelle du contexte",
        "source": "src/K7pl/UsageScale.lean",
        "declaration": "K7pl.UsageScale.projectUsageContext_scale",
        "description": "Extensionalité fonctionnelle, puis distinction des cas none/some.",
    },
)


def esc(value: Any) -> str:
    return html.escape(str(value), quote=True)


def as_dict(value: Any, where: str) -> dict[str, Any]:
    if not isinstance(value, dict):
        raise ValueError(f"{where} must be an object")
    return value


def validate_export(value: Any) -> dict[str, Any]:
    data = as_dict(value, "Paperproof export")
    if not isinstance(data.get("steps"), list) or not data["steps"]:
        raise ValueError("Paperproof export has no tactic steps; refusing to claim a visualization")
    if not isinstance(data.get("allGoals"), list):
        raise ValueError("Paperproof export is missing allGoals")
    for index, value in enumerate(data["steps"]):
        step = as_dict(value, f"steps[{index}]")
        if not isinstance(step.get("tacticString"), str) or not step["tacticString"].strip():
            raise ValueError(f"steps[{index}] has no tacticString")
        as_dict(step.get("goalBefore"), f"steps[{index}].goalBefore")
        for field in ("goalsAfter", "spawnedGoals"):
            if not isinstance(step.get(field), list):
                raise ValueError(f"steps[{index}].{field} must be an array")
        position = as_dict(step.get("position"), f"steps[{index}].position")
        for end in ("start", "stop"):
            point = as_dict(position.get(end), f"steps[{index}].position.{end}")
            for coordinate in ("line", "character"):
                if type(point.get(coordinate)) is not int or point[coordinate] < 0:
                    raise ValueError(f"steps[{index}].position.{end}.{coordinate} must be a nonnegative integer")
    return data


def declaration_line(source: str, name: str) -> int:
    short = re.escape(name.rsplit(".", 1)[-1])
    pattern = re.compile(r"^\s*(?:(?:private|protected|noncomputable)\s+)*(?:theorem|lemma)\s+" + short + r"\b")
    lines = [index for index, line in enumerate(source.splitlines(), 1) if pattern.search(line)]
    if len(lines) != 1:
        raise ValueError(f"expected one declaration for {name}, found {lines}")
    return lines[0]


def build_artifact(target: dict[str, str], export_value: Any, source: str, revision: str,
                   main_toolchain: str) -> dict[str, Any]:
    export = validate_export(export_value)
    start = declaration_line(source, target["declaration"])
    step_ends = [step["position"]["stop"]["line"] + 1 for step in export["steps"]]
    end = max([start, *step_ends])
    source_url = f"{REPOSITORY_URL}/blob/{revision}/{target['source']}#L{start}-L{end}"
    goals = sorted(export["allGoals"], key=lambda item: str(item.get("id", "")) if isinstance(item, dict) else str(item))
    return {
        "schemaVersion": SCHEMA_VERSION,
        "status": "extracted",
        "slug": target["slug"],
        "identity": {
            "declaration": target["declaration"], "source": target["source"],
            "sourceRevision": revision, "declarationLine": start,
            "sourceLines": {"start": start, "end": end}, "sourceUrl": source_url,
            "sourceSha256": hashlib.sha256(source.encode("utf-8")).hexdigest(),
        },
        "editorial": {"title": target["title"], "description": target["description"]},
        "provenance": {
            "extractor": "Paperproof terminal export",
            "paperproofRevision": PAPERPROOF_REVISION,
            "paperproofToolchain": PAPERPROOF_TOOLCHAIN,
            "k7plMainToolchain": main_toolchain,
            "generatedFromExactRevision": revision,
        },
        "guarantees": {
            "paperproofProducedTacticObservations": True,
            "k7plMainToolchainVerifiedByThisArtifact": False,
            "semanticCorrespondenceToNormativeSpecificationEstablished": False,
            "proofAuthority": "Lean kernel checking is independent of this visualization artifact.",
        },
        "limits": [
            "The extractor runs under a separate Lean toolchain; this artifact does not replace the K7PL Lean 4.34.0 build.",
            "Paperproof reports observed tactic goals and hypotheses, not a universal representation of all Lean proof forms.",
            "This curated target list is not an exhaustive inventory of declarations.",
            "No normative specification-to-declaration correspondence is inferred.",
            "A missing after-goal association means it was not reported for this transition, not that no goal ever existed.",
        ],
        "extracted": {"steps": export["steps"], "allGoals": goals},
    }


def render_goal(value: Any, title: str) -> str:
    goal = as_dict(value, "goal")
    parts = [
        f'<section class="goal" aria-label="{esc(title)}"><h4>{esc(title)}</h4>',
        f'<pre class="expression">{esc(goal.get("type", "Type non fourni par l’extracteur"))}</pre>',
    ]
    hypotheses = goal.get("hyps", [])
    if isinstance(hypotheses, list) and hypotheses:
        parts.append(f'<details><summary>Hypothèses et variables ({len(hypotheses)})</summary><ul>')
        for value in hypotheses:
            hyp = as_dict(value, "hypothesis")
            role = {"proof": "preuve", "data": "donnée", "universe": "univers"}.get(
                hyp.get("isProof"), "rôle non précisé")
            parts.append(
                f'<li><strong>{esc(hyp.get("username", "?"))}</strong> : '
                f'<code>{esc(hyp.get("type", "type non fourni"))}</code> '
                f'<span class="tag">{esc(role)}</span></li>')
        parts.append("</ul></details>")
    else:
        parts.append('<p class="muted">Aucune hypothèse n’est rapportée pour cet objectif dans cet extrait.</p>')
    parts.append("</section>")
    return "".join(parts)


def render_step(step: dict[str, Any], number: int, source_url: str) -> str:
    pos = step["position"]
    first, last = pos["start"]["line"] + 1, max(pos["start"]["line"] + 1, pos["stop"]["line"] + 1)
    line_url = source_url.split("#", 1)[0] + f"#L{first}-L{last}"
    after = step["goalsAfter"]
    if after:
        after_html = f"<h4>Objectifs après ({len(after)})</h4>" + "".join(
            render_goal(goal, f"Objectif après {i}") for i, goal in enumerate(after, 1))
    else:
        after_html = '<h4>Objectifs après</h4><p class="state">Aucun objectif après n’est associé à cette transition dans l’export.</p>'
    spawned = step["spawnedGoals"]
    if spawned:
        after_html += f"<h4>Objectifs créés hors de la branche associée ({len(spawned)})</h4>" + "".join(
            render_goal(goal, f"Objectif créé {i}") for i, goal in enumerate(spawned, 1))
    tactic = step["tacticString"]
    return (
        f'<li class="step" id="step-{number}"><header class="step-heading">'
        f'<strong>Étape {number}</strong><code>{esc(tactic)}</code>'
        f'<a href="{esc(line_url)}">Source Lean : lignes {first}–{last}</a></header>'
        f'<div class="transition"><div>{render_goal(step["goalBefore"], "Objectif avant la tactique")}</div>'
        f'<div class="arrow" aria-hidden="true">→</div>'
        f'<section class="tactic"><h4>Tactique observée</h4><pre>{esc(tactic)}</pre>'
        f'<p class="muted">Position source {pos["start"]["line"] + 1}:{pos["start"]["character"] + 1}</p></section>'
        f'<div class="arrow" aria-hidden="true">→</div><section class="outcomes">{after_html}</section></div></li>')


CSS = """
:root { color-scheme: light dark; --line: #858585; --soft: color-mix(in srgb, CanvasText 6%, Canvas); }
* { box-sizing: border-box; }
body { max-width: 1160px; margin: 0 auto; padding: 1rem; font: 1rem/1.55 system-ui, sans-serif; background: Canvas; color: CanvasText; }
a { color: LinkText; } code, pre { font-family: ui-monospace, SFMono-Regular, Consolas, monospace; overflow-wrap: anywhere; }
pre { white-space: pre-wrap; } header { border-bottom: 2px solid var(--line); margin-bottom: 1.2rem; }
h1 { font-size: clamp(1.45rem, 4vw, 2.2rem); line-height: 1.2; }
.card, .notice, .goal, .tactic, .outcomes { border: 1px solid var(--line); border-radius: .35rem; padding: .8rem; min-width: 0; }
.notice { border-left-width: .4rem; margin: 1rem 0; } .muted { opacity: .85; }
.steps { padding-left: 2rem; } .step { margin: 1.5rem 0; } .step-heading { display: flex; flex-wrap: wrap; gap: .6rem 1rem; align-items: baseline; }
.transition { display: grid; grid-template-columns: minmax(0,1fr) auto minmax(0,.8fr) auto minmax(0,1fr); align-items: stretch; gap: .5rem; }
.goal { margin: .5rem 0; background: var(--soft); } .expression { white-space: pre-wrap; }
.arrow { display: grid; place-items: center; font-size: 1.4rem; } .tag { border: 1px solid var(--line); border-radius: 1rem; padding: .05rem .35rem; font-size: .8rem; }
.state { border: 1px dashed var(--line); padding: .5rem; } li { margin-block: .35rem; }
@media(max-width: 820px) { .transition { grid-template-columns: minmax(0,1fr); } .arrow { transform: rotate(90deg); min-height: 1rem; } }
@media print { body { max-width: none; } a { color: inherit; text-decoration: none; } }
"""


def page(title: str, body: str, description: str = "") -> str:
    return f"""<!doctype html>
<html lang="fr"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="{esc(description)}"><title>{esc(title)}</title><style>{CSS}</style></head><body>{body}</body></html>
"""


def render_proof(artifact: dict[str, Any]) -> str:
    ident, editorial = artifact["identity"], artifact["editorial"]
    steps = artifact["extracted"]["steps"]
    content = "".join(render_step(step, i, ident["sourceUrl"]) for i, step in enumerate(steps, 1))
    prov = artifact["provenance"]
    notice = (
        "<h2>Statut et portée</h2><p>Les étapes et états affichés sont extraits par Paperproof ; "
        "ils ne constituent pas une preuve autonome. Le code source exact reste canonique.</p>"
        f'<p>Toolchain de K7PL : <code>{esc(prov["k7plMainToolchain"])}</code>. '
        f'Extracteur isolé : <code>{esc(prov["paperproofToolchain"])}</code>, '
        f'révision Paperproof <code>{esc(prov["paperproofRevision"])}</code>.</p>'
        "<p>L’extraction ne vérifie pas la correspondance normative et ne remplace pas la compilation K7PL.</p>"
    )
    body = (
        f'<header><p><a href="index.html">Catalogue des preuves</a> · '
        f'<a href="../navigation/index.html">Exploration documentaire</a></p>'
        f'<h1>{esc(editorial["title"])}</h1><p>{esc(editorial["description"])}</p>'
        f'<p><strong>Déclaration :</strong> <code>{esc(ident["declaration"])}</code></p>'
        f'<p><strong>Source :</strong> <a href="{esc(ident["sourceUrl"])}">{esc(ident["source"])} '
        f'lignes {ident["sourceLines"]["start"]}–{ident["sourceLines"]["end"]}</a></p></header>'
        f'<section class="notice">{notice}</section><h2>Transitions tactiques extraites ({len(steps)})</h2>'
        f'<ol class="steps">{content}</ol><h2>Limites connues</h2><ul>'
        + "".join(f"<li>{esc(item)}</li>" for item in artifact["limits"])
        + "</ul><footer><p>Artefact JSON : <a href=\"data/" + esc(artifact["slug"]) +
        '.json">données extraites avec provenance</a>.</p></footer>'
    )
    return page(editorial["title"] + " — preuves K7PL", body, editorial["description"])


def render_index(artifacts: list[dict[str, Any]], revision: str) -> str:
    cards = []
    for item in artifacts:
        ident, editorial = item["identity"], item["editorial"]
        cards.append(
            f'<article class="card"><h2><a href="{esc(item["slug"])}.html">{esc(editorial["title"])}</a></h2>'
            f'<p>{esc(editorial["description"])}</p><p><code>{esc(ident["declaration"])}</code></p>'
            f'<p>{len(item["extracted"]["steps"])} transitions tactiques extraites. '
            f'<a href="{esc(ident["sourceUrl"])}">Source Lean exacte</a> · '
            f'<a href="data/{esc(item["slug"])}.json">JSON</a></p></article>')
    body = (
        '<p><a href="../navigation/index.html">← Retour à l’exploration documentaire</a></p>'
        "<h1>Visualisations de preuves K7PL</h1>"
        "<p>Vues statiques dérivées des états de buts et d’hypothèses observés par Paperproof. "
        "Elles complètent le code canonique et restent lisibles sans JavaScript.</p>"
        '<section class="notice"><h2>Ce que ces vues établissent — et n’établissent pas</h2>'
        "<p>Les sources sont des déclarations réelles de K7PL et leurs liens pointent vers la révision exacte "
        f"<code>{esc(revision)}</code>. Les extractions utilisent une toolchain séparée, épinglée à Paperproof. "
        "L’artefact ne démontre pas à lui seul que la version principale de Lean a vérifié le théorème ; "
        "le build Lean de K7PL reste le contrôle formel pertinent. Aucun lien de conformité normative n’est inféré.</p>"
        "</section><h2>Exemples couverts par cette tranche</h2>" + "".join(cards)
        + "<h2>Hors couverture</h2><p>Les preuves en style terme, définitions, types inductifs et autres formes "
        "ne sont pas représentés par cette sélection. Leur absence de ce catalogue ne signifie ni inexistence "
        "ni absence de vérification ; ces vues ne couvrent qu’une sélection explicite de preuves tactiques.</p>"
    )
    return page("Visualisations de preuves K7PL", body, "Visualisations statiques des transitions tactiques extraites de vraies preuves K7PL.")


def inject_nav_link(path: Path) -> None:
    text = path.read_text(encoding="utf-8")
    marker = '<a href="../proofs/index.html">Visualisations de preuves</a>'
    if marker in text:
        return
    closing = re.search(r"</nav>", text, re.IGNORECASE)
    if not closing:
        raise ValueError(f"cannot inject proof link: no navigation element in {path}")
    text = text[:closing.start()] + " · " + marker + text[closing.start():]
    path.write_text(text, encoding="utf-8")


def validate_site(site: Path, artifacts: list[dict[str, Any]], revision: str) -> None:
    index = site / "proofs" / "index.html"
    if not index.is_file():
        raise ValueError("proof index was not generated")
    nav = site / "navigation" / "index.html"
    if not nav.is_file() or 'href="../proofs/index.html"' not in nav.read_text(encoding="utf-8"):
        raise ValueError("navigation link to proof visualizations is missing")
    for artifact in artifacts:
        ident = artifact["identity"]
        if ident["sourceRevision"] != revision or revision not in ident["sourceUrl"]:
            raise ValueError(f"source revision mismatch for {ident['declaration']}")
        slug = artifact["slug"]
        for rel in (Path("proofs") / f"{slug}.html", Path("proofs/data") / f"{slug}.json"):
            if not (site / rel).is_file():
                raise ValueError(f"missing generated artifact {rel}")
        json_data = json.loads((site / "proofs/data" / f"{slug}.json").read_text(encoding="utf-8"))
        validate_export({"steps": json_data["extracted"]["steps"], "allGoals": json_data["extracted"]["allGoals"]})
        html_data = (site / "proofs" / f"{slug}.html").read_text(encoding="utf-8")
        if ident["sourceUrl"] not in html_data or "sans JavaScript" in html_data and "<script" in html_data:
            raise ValueError(f"invalid source or script fallback in proof page {slug}")
    if "not represented" in index.read_text(encoding="utf-8").lower():
        raise ValueError("unsupported states must be documented in French, not with ambiguous English copy")


def extract_one(root: Path, extractor: Path, target: dict[str, str], revision: str,
                main_toolchain: str, output_root: Path) -> dict[str, Any]:
    source_path = root / target["source"]
    source = source_path.read_text(encoding="utf-8")
    raw_path = output_root / f".{target['slug']}.paperproof.json"

    # Paperproof's Lean frontend rejects source paths outside its Lake workspace.
    # Stage an exact text copy inside that workspace; source links and provenance
    # continue to refer to the canonical repository file, never to this temporary copy.
    raw_path.unlink(missing_ok=True)
    with tempfile.TemporaryDirectory(prefix="k7pl-proof-source-", dir=extractor) as staging_dir:
        staged_path = Path(staging_dir) / source_path.name
        staged_path.write_text(source, encoding="utf-8")
        command = ["lake", "exe", "terminal", str(staged_path.resolve()),
                   target["declaration"], str(raw_path.resolve())]
        try:
            result = subprocess.run(command, cwd=extractor, text=True, capture_output=True, check=False)
            if result.returncode or not raw_path.is_file():
                raise RuntimeError(
                    f"Paperproof extraction failed for {target['declaration']} (exit {result.returncode}).\\n"
                    f"stdout:\\n{result.stdout}\\nstderr:\\n{result.stderr}")
            raw = json.loads(raw_path.read_text(encoding="utf-8"))
            return build_artifact(target, raw, source, revision, main_toolchain)
        finally:
            raw_path.unlink(missing_ok=True)


def validate_lock(extractor: Path) -> None:
    toolchain = (extractor / "lean-toolchain").read_text(encoding="utf-8").strip()
    if toolchain != PAPERPROOF_TOOLCHAIN:
        raise ValueError(f"Paperproof toolchain drift: expected {PAPERPROOF_TOOLCHAIN}, got {toolchain}")
    lock = json.loads((extractor / "lake-manifest.json").read_text(encoding="utf-8"))
    packages = {item["name"]: item for item in lock.get("packages", [])}
    pp = packages.get("Paperproof", {})
    mathlib = packages.get("mathlib", {})
    if pp.get("rev") != PAPERPROOF_REVISION or pp.get("subDir") != "lean":
        raise ValueError("Paperproof must remain pinned to the reviewed commit and lean subdirectory")
    if mathlib.get("inputRev") != "v4.29.0-rc8":
        raise ValueError("the isolated Paperproof workspace must keep its matching Mathlib release")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo-root", type=Path, default=Path("."))
    parser.add_argument("--site", type=Path, required=True)
    parser.add_argument("--ref", required=True)
    parser.add_argument("--extractor-dir", type=Path, default=Path("tooling/paperproof-export"))
    parser.add_argument("--main-toolchain", default="leanprover/lean4:v4.34.0")
    args = parser.parse_args()
    root = args.repo_root.resolve()
    site = args.site.resolve()
    extractor = (root / args.extractor_dir).resolve()
    validate_lock(extractor)
    output = site / "proofs"
    (output / "data").mkdir(parents=True, exist_ok=True)
    artifacts = [extract_one(root, extractor, target, args.ref, args.main_toolchain, output) for target in TARGETS]
    for artifact in artifacts:
        slug = artifact["slug"]
        (output / f"{slug}.html").write_text(render_proof(artifact), encoding="utf-8")
        (output / "data" / f"{slug}.json").write_text(
            json.dumps(artifact, ensure_ascii=False, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    (output / "index.html").write_text(render_index(artifacts, args.ref), encoding="utf-8")
    manifest = {
        "schemaVersion": SCHEMA_VERSION,
        "sourceRevision": args.ref,
        "mainToolchain": args.main_toolchain,
        "extractorToolchain": PAPERPROOF_TOOLCHAIN,
        "paperproofRevision": PAPERPROOF_REVISION,
        "declarations": [item["identity"]["declaration"] for item in artifacts],
        "limits": ["Curated tactic proofs only", "No inferred normative correspondence", "HTML is a derived view, not proof evidence"],
    }
    (output / "manifest.json").write_text(json.dumps(manifest, ensure_ascii=False, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    inject_nav_link(site / "navigation" / "index.html")
    validate_site(site, artifacts, args.ref)
    print(f"Generated {len(artifacts)} static proof views for {args.ref}")
    for artifact in artifacts:
        print(f"  {artifact['identity']['declaration']}: {len(artifact['extracted']['steps'])} tactic observations")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
