# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1
import argparse
import datetime
import re
import subprocess
from pathlib import Path

ROOTS = ("docs/tracking/", "docs/research/", "docs/method/", "docs/peer-review/", "docs/bibliography/", "docs/history/")
CANDIDATES = {
    "tracking": "À qualifier: STATUS / ASSURANCE / RESEARCH / METHOD / archive",
    "research": "RESEARCH.md",
    "method": "METHOD.md",
    "peer-review": "docs/peer-review/",
    "bibliography": "corpus bibliographique ou conservation legacy",
    "history": "docs/history/",
}
LINK_RE = re.compile(r"\[[^\]]*\]\(([^)]+)\)")
DOI_RE = re.compile(r"\b10\.\d{4,9}/[-._;()/:A-Z0-9]+\b", re.I)
CITATION_RE = re.compile(r"@(?:article|book|inproceedings|misc|techreport|phdthesis)\s*\{\s*([^,\s]+)", re.I)

def git_files():
    out = subprocess.check_output(["git", "ls-files", "--", *ROOTS], text=True)
    return [Path(p) for p in out.splitlines() if p]

def last_modified(path):
    try:
        return subprocess.check_output(["git", "log", "-1", "--format=%cI", "--", str(path)], text=True).strip()
    except subprocess.CalledProcessError:
        return "UNKNOWN"

def internal_links(text):
    result = []
    for target in LINK_RE.findall(text):
        if target.startswith(("#", "http:", "https:", "mailto:")):
            continue
        result.append(target.split("#", 1)[0])
    return sorted(set(result))

def references(text):
    values = set(DOI_RE.findall(text))
    values.update(CITATION_RE.findall(text))
    return sorted(values)

def candidate(path):
    return CANDIDATES.get(path.parts[1] if len(path.parts) > 1 else "", "À qualifier")

def render(output):
    files = git_files()
    rows = []
    register = []
    for path in files:
        content = path.read_text(encoding="utf-8")
        links = internal_links(content)
        refs = references(content)
        rows.append("| `{}` | {} | {} | {} | {} | {} | {} | NOT STARTED |".format(
            path, path.stat().st_size, last_modified(path), len(content.splitlines()),
            len(links), len(refs), candidate(path)
        ))
        register.append("| `{}` |  |  |  |  |  |  |  | NOT STARTED |".format(path))

    today = datetime.date.today().isoformat()
    body = [
        "# Legacy inventory", "",
        "Inventory generated from the Git working tree on {}.".format(today), "",
        "The inventory is a migration control register, not a classification by directory alone. Candidate destinations are provisional and require semantic qualification.", "",
        "## M0 snapshot", "",
        "| Source | Size (bytes) | Last modification | Lines | Internal links | References | Candidate destination | Migration status |",
        "|---|---:|---|---:|---:|---:|---|---|", *rows, "",
        "## M2 semantic register", "",
        "The following fields are completed during semantic qualification. They must not be inferred mechanically from the source directory.", "",
        "| Source | Destination | Nature | Epistemic state | Action | Provenance preserved | Links to update | Reviewer | Validation |",
        "|---|---|---|---|---|---|---|---|---|", *register, "",
        "Allowed epistemic states: `normatif`, `établi`, `hypothèse`, `décision`, `observation`, `preuve`, `critique`, `historique`, `obsolète`.", "",
        "A source may contribute to several destinations. No source-to-destination bijection is assumed.", ""
    ]
    path = Path(output)
    marker = "<!-- GENERATED CONTENT START -->"
    end_marker = "<!-- GENERATED CONTENT END -->"
    existing = path.read_text(encoding="utf-8") if path.exists() else ""
    prefix, sep, _ = existing.partition(marker)
    if not sep:
        raise SystemExit("{}: missing generated-content marker".format(path))
    path.write_text(prefix + marker + "\n\n" + "\n".join(body) + "\n" + end_marker + "\n", encoding="utf-8")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", default="docs/migration/LEGACY-INVENTORY.md")
    render(parser.parse_args().output)
