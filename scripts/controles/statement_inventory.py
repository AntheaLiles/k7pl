# SPDX-FileCopyrightText: 2026 K7PL contributors
#
# SPDX-License-Identifier: CC0-1.0
"""Check that the reviewed C8 legacy inventory still matches the manuscript sources.

This is deliberately a read-only consistency check. It does not classify statements and does not
rewrite source files or the inventory.
"""

from __future__ import annotations

import argparse
import re
import sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCRIPTS = ROOT / "scripts"
if str(SCRIPTS) not in sys.path:
    sys.path.insert(0, str(SCRIPTS))

import manuscript_metrics as mm  # noqa: E402

DEFAULT_INVENTORY = ROOT / "docs" / "tracking" / "LEAN-STATEMENT-INVENTORY.md"
THM_REF = re.compile(r'\{num "(thm:[^"]+)"\}')
TABLE_ROW = re.compile(
    r"^\| `(?P<path>[^\`]+)` \| (?P<line>\d+) \| "
    r"`(?P<label>[^\`]+)` \| (?P<status>[^|]+) \| (?P<level>[^|]+) \| "
    r"(?P<title>.*?) \| (?P<sketch>oui|non) \|$"
)


def normalize(value: str) -> str:
    return " ".join(value.split())


def source_inventory() -> list[dict[str, object]]:
    """Extract only mechanically observable fields from the active manuscript module tree."""
    rows: list[dict[str, object]] = []
    for module, _section in mm.walk():
        for match in mm.THM.finditer(module.text):
            closing = module.text.find("\n::::\n", match.end())
            if closing < 0:
                raise ValueError(f"{module.path}: unclosed :::::thm block at offset {match.start()}")
            block = module.text[match.end() : closing]
            args = mm.args_of(match.group(1))
            title_match = re.search(r"^:::title\n(.*?)\n:::", block, re.S | re.M)
            statement_match = re.search(r"^:::statement[^\n]*\n", block, re.M)
            sketch_match = re.search(r"^:::proofsketch[^\n]*\n", block, re.M)
            rows.append(
                {
                    "path": module.path.relative_to(ROOT).as_posix(),
                    "line": module.text.count("\n", 0, match.start()) + 1,
                    "label": args.get("label", ""),
                    "status": args.get("status", "theoreme"),
                    "level": args.get("level", "langage"),
                    "title": normalize(title_match.group(1)) if title_match else "",
                    "statement": statement_match is not None,
                    "sketch": sketch_match is not None,
                    "dependencies": sorted(set(THM_REF.findall(block))),
                }
            )
    return rows


def inventory_rows(path: Path) -> list[dict[str, object]]:
    """Read the detailed table, not the narrative sections, from the Markdown inventory."""
    text = path.read_text(encoding="utf-8")
    try:
        table = text.split("## 2. Inventaire détaillé", 1)[1].split(
            "## 3. Classification sémantique encore requise", 1
        )[0]
    except IndexError as exc:
        raise ValueError(f"{path}: expected inventory section headings are missing") from exc

    rows: list[dict[str, object]] = []
    for line in table.splitlines():
        match = TABLE_ROW.match(line)
        if not match:
            continue
        rows.append(
            {
                "path": match.group("path"),
                "line": int(match.group("line")),
                "label": match.group("label"),
                "status": match.group("status").strip(),
                "level": match.group("level").strip(),
                "title": normalize(match.group("title").replace(r"\|", "|")),
                "sketch": match.group("sketch") == "oui",
            }
        )
    return rows


def summary_counts(text: str, section: str, next_section: str) -> dict[str, int]:
    """Read the small status/level count table from the inventory document."""
    try:
        body = text.split(section, 1)[1].split(next_section, 1)[0]
    except IndexError as exc:
        raise ValueError(f"missing summary section {section!r}") from exc
    counts: dict[str, int] = {}
    for match in re.finditer(r"^\| `([^\`]+)` \| (\d+) \|$", body, re.M):
        counts[match.group(1)] = int(match.group(2))
    return counts


def check_inventory(path: Path = DEFAULT_INVENTORY) -> list[str]:
    """Return every drift or structural inconsistency found; an empty list means consistent."""
    document = path.read_text(encoding="utf-8")
    actual = source_inventory()
    listed = inventory_rows(path)
    errors: list[str] = []

    for name, rows in (("source", actual), ("inventory", listed)):
        labels = [str(row["label"]) for row in rows if row["label"]]
        duplicates = sorted({label for label in labels if labels.count(label) > 1})
        if duplicates:
            errors.append(f"{name}: duplicate labels: {', '.join(duplicates)}")
        missing = [row for row in rows if not row["label"]]
        if missing:
            errors.append(f"{name}: {len(missing)} row(s) have no label")

    source_labels = {str(row["label"]) for row in actual if row["label"]}
    for row in actual:
        for dependency in row["dependencies"]:
            if dependency not in source_labels:
                errors.append(
                    f'unresolved theorem dependency in {row["path"]}:{row["line"]} '
                    f'({row["label"]} -> {dependency})'
                )

    actual_by_key = {(r["path"], r["line"], r["label"]): r for r in actual}
    listed_by_key = {(r["path"], r["line"], r["label"]): r for r in listed}
    if len(actual_by_key) != len(actual):
        errors.append("source: duplicate (path, line, label) keys")
    if len(listed_by_key) != len(listed):
        errors.append("inventory: duplicate (path, line, label) keys")

    for key in sorted(actual_by_key.keys() - listed_by_key.keys()):
        errors.append(f"missing inventory row for {key[0]}:{key[1]} ({key[2]})")
    for key in sorted(listed_by_key.keys() - actual_by_key.keys()):
        errors.append(f"stale inventory row {key[0]}:{key[1]} ({key[2]})")

    for key in sorted(actual_by_key.keys() & listed_by_key.keys()):
        source = actual_by_key[key]
        listed_row = listed_by_key[key]
        for field in ("status", "level", "title", "sketch"):
            if source[field] != listed_row[field]:
                errors.append(
                    f"{key[0]}:{key[1]} ({key[2]}): {field} differs "
                    f"(source={source[field]!r}, inventory={listed_row[field]!r})"
                )
        if not source["statement"]:
            errors.append(f"{key[0]}:{key[1]} ({key[2]}): missing :::statement slot")

    if len(actual) != len(listed):
        errors.append(f"row count differs: source={len(actual)}, inventory={len(listed)}")

    source_statuses = Counter(str(row["status"]) for row in actual)
    source_levels = Counter(str(row["level"]) for row in actual)
    status_table = summary_counts(
        document, "### Répartition par statut historique", "### Répartition par niveau historique"
    )
    level_table = summary_counts(
        document, "### Répartition par niveau historique", "### Répartition par fichier"
    )
    if status_table != dict(source_statuses):
        errors.append(f"status summary differs: source={dict(source_statuses)}, inventory={status_table}")
    if level_table != dict(source_levels):
        errors.append(f"level summary differs: source={dict(source_levels)}, inventory={level_table}")

    return errors



def dependency_cycles(rows: list[dict[str, object]]) -> list[list[str]]:
    """Return strongly connected dependency components that may indicate cycles.

    References are syntactic edges, not necessarily proof premises. The caller must
    review reported components rather than treating them as automatically invalid.
    """
    graph = {
        str(row["label"]): {str(dep) for dep in row["dependencies"]}
        for row in rows
        if row["label"]
    }
    for targets in list(graph.values()):
        for target in targets:
            graph.setdefault(target, set())

    index = 0
    indices: dict[str, int] = {}
    lowlinks: dict[str, int] = {}
    stack: list[str] = []
    on_stack: set[str] = set()
    cycles: list[list[str]] = []

    def visit(node: str) -> None:
        nonlocal index
        indices[node] = index
        lowlinks[node] = index
        index += 1
        stack.append(node)
        on_stack.add(node)

        for target in sorted(graph[node]):
            if target not in indices:
                visit(target)
                lowlinks[node] = min(lowlinks[node], lowlinks[target])
            elif target in on_stack:
                lowlinks[node] = min(lowlinks[node], indices[target])

        if lowlinks[node] == indices[node]:
            component: list[str] = []
            while True:
                member = stack.pop()
                on_stack.remove(member)
                component.append(member)
                if member == node:
                    break
            if len(component) > 1 or node in graph[node]:
                cycles.append(sorted(component))

    for node in sorted(graph):
        if node not in indices:
            visit(node)

    return sorted(cycles)



def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--inventory", type=Path, default=DEFAULT_INVENTORY)
    parser.add_argument("--dependencies", action="store_true", help="print direct theorem-reference edges as Markdown")
    parser.add_argument("--dependency-cycles", action="store_true", help="report possible dependency cycles for semantic review")
    args = parser.parse_args(argv)
    try:
        errors = check_inventory(args.inventory)
    except (OSError, ValueError) as exc:
        print(f"statement inventory: ERROR: {exc}", file=sys.stderr)
        return 1
    if errors:
        for error in errors:
            print(f"statement inventory: ERROR: {error}", file=sys.stderr)
        return 1
    rows = source_inventory()
    files = len({str(row["path"]) for row in rows})
    edges = [(str(row["label"]), dep, str(row["path"]), int(row["line"])) for row in rows for dep in row["dependencies"]]
    if args.dependency_cycles:
        cycles = dependency_cycles(rows)
        if not cycles:
            print("statement dependency audit: no syntactic cycles detected")
        else:
            for component in cycles:
                print("possible dependency cycle (semantic review required): " + " <-> ".join(component))
    elif args.dependencies:
        print("| Source label | Direct dependency | Source location |")
        print("|---|---|---|")
        for source, target, location, line in edges:
            print(f"| `{source}` | `{target}` | `{location}:{line}` |")
    else:
        print(f"statement inventory: OK — {len(rows)} blocks across {files} source files; {len(edges)} direct theorem-reference edges")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
