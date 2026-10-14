# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CC0-1.0
"""Check the active C8 statement inventory against the controlled migration register.

The pre-migration inventory remains a frozen historical snapshot, kept as an appendix of the
migration register. This checker compares the current source ontology with the migration register
and verifies syntactic statement references; it does not validate mathematical truth or proof
adequacy.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCRIPTS = ROOT / "scripts"
if str(SCRIPTS) not in sys.path:
    sys.path.insert(0, str(SCRIPTS))

import manuscript_metrics as mm  # noqa: E402

DEFAULT_INVENTORY = ROOT / "docs" / "tracking" / "LEAN-STATEMENT-MIGRATION.md"
# The frozen pre-migration snapshot is the appendix of the migration register.
HISTORICAL_INVENTORY = DEFAULT_INVENTORY
HISTORICAL_TABLE_START = "### 2. Inventaire détaillé"
HISTORICAL_TABLE_END = "### 3. Classification sémantique encore requise"
EXPECTED_COMPANION_LABELS = {
    "def:elaboration",
    "req:schema_reinvocation_compatibility",
    "thm:interface_jugement_cloture",
    "req:homomorphisme_roues_realisation",
    "req:sedimentation_graduee",
    # Split of thm:raffinement ratified by the author on 2026-10-12 (option a).
    "thm:raffinement_effacement",
    "thm:raffinement_non_interference",
    "thm:raffinement_precision",
}
HISTORICAL_ROW = re.compile(r"^\| `[^\`]+` \| \d+ \| `(?P<label>[^\`]+)` \|", re.M)
HISTORICAL_LEVEL_ROW = re.compile(
    r"^\| `[^`]+` \| \d+ \| `(?P<label>[^`]+)` \| [^|]* \| (?P<level>[^|]+) \|", re.M
)


def normalize(value: str) -> str:
    return " ".join(value.split()).strip(chr(96))


def source_inventory() -> list[dict[str, object]]:
    """Extract observable ontology fields and direct statement references from source."""
    rows: list[dict[str, object]] = []
    for row in mm.statements():
        rows.append(
            {
                "path": row["path"],
                "line": row["line"],
                "label": row["label"],
                "kind": row["kind"],
                "role": row["role"] or "—",
                "state": row["state"],
                "evidence": row["evidence"],
                "scope": row["scope"],
                "level": row["niveau"],
                "dependencies": row["dependencies"],
            }
        )
    return rows


def inventory_rows(path: Path) -> list[dict[str, object]]:
    """Read ontology rows from the current controlled migration register."""
    text = path.read_text(encoding="utf-8")
    try:
        table = text.split("## Classification courante", 1)[1]
    except IndexError as exc:
        raise ValueError(f"{path}: missing Classification courante table") from exc

    rows: list[dict[str, object]] = []
    tick = chr(96)
    for line in table.splitlines():
        if not line.startswith("| " + tick):
            continue
        cells = [cell.strip() for cell in line.strip().strip("|").split("|")]
        if len(cells) < 10:
            continue
        label = normalize(cells[0])
        source = normalize(cells[1])
        if not label.startswith(("thm:", "req:", "def:", "lit:", "ex:", "cex:")):
            continue
        rows.append(
            {
                "label": label,
                "path": source,
                "kind": normalize(cells[2]),
                "role": normalize(cells[3]) or "—",
                "state": normalize(cells[4]),
                "evidence": normalize(cells[5]),
                "scope": normalize(cells[6]),
                "level": normalize(cells[8]),
            }
        )
    return rows


def historical_table(text: str) -> str:
    """Return the detailed table of the frozen pre-migration snapshot."""
    return text.split(HISTORICAL_TABLE_START, 1)[1].split(HISTORICAL_TABLE_END, 1)[0]


def historical_labels(path: Path | None = None) -> set[str]:
    """Read the 69 labels from the immutable pre-migration inventory snapshot."""
    path = path or HISTORICAL_INVENTORY
    text = path.read_text(encoding="utf-8")
    try:
        table = historical_table(text)
    except IndexError as exc:
        raise ValueError(f"{path}: expected historical inventory headings are missing") from exc
    return set(HISTORICAL_ROW.findall(table))


def historical_levels(path: Path | None = None) -> dict[str, str]:
    """Read original level metadata so migration cannot silently rewrite it."""
    path = path or HISTORICAL_INVENTORY
    text = path.read_text(encoding="utf-8")
    try:
        table = historical_table(text)
    except IndexError as exc:
        raise ValueError(f"{path}: expected historical inventory headings are missing") from exc
    return {
        match.group("label"): normalize(match.group("level"))
        for match in HISTORICAL_LEVEL_ROW.finditer(table)
    }


def check_inventory(path: Path = DEFAULT_INVENTORY) -> list[str]:
    """Return source/register drift and unresolved direct statement references."""
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

    actual_by_label = {str(row["label"]): row for row in actual if row["label"]}
    listed_by_label = {str(row["label"]): row for row in listed if row["label"]}
    baseline = historical_labels()
    baseline_levels = historical_levels()
    active_labels = set(actual_by_label)
    for label in sorted(baseline - active_labels):
        errors.append(f"historical label lost during migration: {label}")
    for label in sorted(baseline & active_labels):
        historical_level = baseline_levels.get(label)
        current_level = str(actual_by_label[label]["level"])
        if historical_level is None:
            errors.append(f"historical inventory has no level for {label}")
        elif normalize(current_level) != historical_level:
            errors.append(
                f"historical level changed: {label} (historical={historical_level!r}, current={current_level!r})"
            )

    added_labels = active_labels - baseline
    if added_labels != EXPECTED_COMPANION_LABELS:
        errors.append(
            f"companion labels differ: expected={sorted(EXPECTED_COMPANION_LABELS)}, actual={sorted(added_labels)}"
        )

    for label in sorted(actual_by_label.keys() - listed_by_label.keys()):
        row = actual_by_label[label]
        errors.append(f'missing inventory row for {row["path"]}:{row["line"]} ({label})')
    for label in sorted(listed_by_label.keys() - actual_by_label.keys()):
        row = listed_by_label[label]
        errors.append(f'stale inventory row {row["path"]} ({label})')

    fields = ("path", "kind", "role", "state", "evidence", "scope", "level")
    for label in sorted(actual_by_label.keys() & listed_by_label.keys()):
        source = actual_by_label[label]
        recorded = listed_by_label[label]
        for field in fields:
            if normalize(str(source[field])) != normalize(str(recorded[field])):
                errors.append(
                    f'{label}: {field} differs (source={source[field]!r}, register={recorded[field]!r})'
                )

    if len(actual) != len(listed):
        errors.append(f"row count differs: source={len(actual)}, register={len(listed)}")

    active_labels = set(actual_by_label)
    for row in actual:
        for dependency in row["dependencies"]:
            if dependency not in active_labels:
                errors.append(
                    f'{row["path"]}:{row["line"]} ({row["label"]}): unresolved statement reference {dependency}'
                )

    return errors


def dependency_cycles(rows: list[dict[str, object]]) -> list[list[str]]:
    """Return cyclic components in the syntactic statement-reference graph.

    References are not necessarily proof premises; each reported component needs semantic review.
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
        indices[node] = lowlinks[node] = index
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
    output = parser.add_mutually_exclusive_group()
    output.add_argument("--dependencies", action="store_true", help="print direct statement-reference edges as Markdown")
    output.add_argument("--dependency-cycles", action="store_true", help="report candidate cycles for semantic review")
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
    edges = [
        (str(row["label"]), str(dep), str(row["path"]), int(row["line"]))
        for row in rows
        for dep in row["dependencies"]
    ]
    if args.dependencies:
        print("| Source label | Direct dependency | Source location |")
        print("|---|---|---|")
        for source, target, path, line in edges:
            print(f"| {source} | {target} | {path}:{line} |")
        print(f"statement dependency audit: {len(edges)} direct reference(s)")
    elif args.dependency_cycles:
        cycles = dependency_cycles(rows)
        if not cycles:
            print("statement dependency audit: no syntactic cycles detected")
        else:
            for component in cycles:
                print("possible dependency cycle (semantic review required): " + " <-> ".join(component))
    else:
        print(f"statement inventory: OK — {len(rows)} blocks across {files} source files; {len(edges)} direct reference(s)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
