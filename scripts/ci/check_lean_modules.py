#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Detect Lean files that no Lake target ever builds.

`lake build` compiles a library from its declared roots and, transitively, from the modules those
roots import. A `.lean` file that is neither a declared root (`lean_lib`/`lean_exe` in
`lakefile.lean`) nor imported from one is never compiled: a false `#guard`, a `sorry` or a warning
turned into an error inside it cannot fail the build. This script reports such files.

Scope and limits (the script fails loudly rather than guess):

* only `lakefile.lean` is understood, and only `lean_lib X where`/`lean_exe x where` declarations
  written at the start of a line, each with a literal `srcDir` and a literal `roots` list (library)
  or `root` name (executable). Lake's defaults (`srcDir := "."`, `roots := #[`X]`, `root := `Main`)
  are deliberately not assumed: leaving a field out is an error, as is any other shape (`globs`, a
  computed root list, a `lean_lib` keyword that the parser does not recognise as a declaration, a
  missing root file, a missing scanned directory). Nothing is ever a silent pass;
* imports are read from the file header only, after comments are removed, following the header
  grammar of Lean 4.34 (`[module] [prelude] ([public] [meta] import [all] Name)*`);
* it checks reachability, not that a reachable module is actually tested or audited.

Exit status: 0 when every scanned file is reachable, 1 when an orphan is found, 2 when the
repository cannot be analysed.
"""

from __future__ import annotations

import argparse
import os
import re
import sys
from dataclasses import dataclass
from pathlib import Path

DEFAULT_SCAN_DIRS = ("src", "tests")

DECLARATION = re.compile(
    r"^(?P<kind>lean_lib|lean_exe)[ \t]+(?P<name>\S+)[ \t]+where\b(?P<rest>[^\n]*)$",
    re.MULTILINE,
)
KEYWORD = re.compile(r"\blean_(?:lib|exe)\b")
# A literal must be the whole value of its field: `"src" / "x"` or `#[`A] ++ more` is a computed value.
ENTRY_END = r"[ \t]*(?:,|$)"
NAME_LITERAL = re.compile(r"`([^\s,\[\]#]+)")


class Unrecognized(Exception):
    """The repository layout cannot be analysed with confidence."""


@dataclass(frozen=True)
class Target:
    """A `lean_lib` or `lean_exe` declaration."""

    kind: str
    name: str
    src_dir: str
    roots: tuple[str, ...]


def strip_comments(text: str) -> str:
    """Blank out Lean comments (line and nested block), keeping strings and line structure."""
    out: list[str] = []
    i, n, depth, in_string = 0, len(text), 0, False
    while i < n:
        ch, pair = text[i], text[i : i + 2]
        if depth > 0:
            if pair == "/-":
                depth += 1
                out.append("  ")
                i += 2
            elif pair == "-/":
                depth -= 1
                out.append("  ")
                i += 2
            else:
                out.append("\n" if ch == "\n" else " ")
                i += 1
        elif in_string:
            out.append(ch)
            if ch == "\\" and i + 1 < n:
                out.append(text[i + 1])
                i += 2
                continue
            if ch == '"':
                in_string = False
            i += 1
        elif pair == "/-":
            depth = 1
            out.append("  ")
            i += 2
        elif pair == "--":
            while i < n and text[i] != "\n":
                out.append(" ")
                i += 1
        else:
            if ch == '"':
                in_string = True
            out.append(ch)
            i += 1
    return "".join(out)


def _string_field(body: str, field: str, label: str) -> str:
    """The value of a ``field := "literal"`` entry."""
    literal = re.search(rf'\b{field}\s*:=\s*"([^"\\]*)"{ENTRY_END}', body, re.MULTILINE)
    if not literal:
        raise Unrecognized(f"{label}: `{field}` is missing or is not a string literal")
    return literal.group(1)


def _name_field(body: str, field: str, label: str) -> str:
    """The value of a ``field := `Name`` entry."""
    literal = re.search(rf"\b{field}\s*:=\s*{NAME_LITERAL.pattern}{ENTRY_END}", body, re.MULTILINE)
    if not literal:
        raise Unrecognized(f"{label}: `{field}` is missing or is not a name literal")
    return literal.group(1)


def _names_field(body: str, field: str, label: str) -> tuple[str, ...]:
    """The names of a ``field := #[`A, `B]`` entry."""
    match = re.search(rf"\b{field}\s*:=\s*#\[(?P<inner>[^\]]*)\]{ENTRY_END}", body, re.MULTILINE)
    if not match:
        raise Unrecognized(f"{label}: `{field}` is missing or is not a literal list of names")
    inner = match.group("inner")
    if NAME_LITERAL.sub("", inner).replace(",", "").strip():
        raise Unrecognized(f"{label}: `{field}` contains something other than name literals")
    return tuple(NAME_LITERAL.findall(inner))


def _body_of(stripped: str, match: re.Match[str]) -> str:
    """The text of a declaration: what follows `where` plus the indented lines after it."""
    lines = [match.group("rest")]
    for line in stripped[match.end() :].splitlines()[1:]:
        if line.strip() and not line[0].isspace():
            break
        lines.append(line)
    return "\n".join(lines)


def parse_lakefile(path: Path) -> list[Target]:
    """Return the `lean_lib`/`lean_exe` targets of `lakefile.lean`, or raise `Unrecognized`."""
    if not path.is_file():
        toml = path.with_name("lakefile.toml")
        hint = " (lakefile.toml is not supported)" if toml.is_file() else ""
        raise Unrecognized(f"{path} not found{hint}")
    stripped = strip_comments(path.read_text(encoding="utf-8"))
    matches = list(DECLARATION.finditer(stripped))
    if not matches:
        raise Unrecognized(f"no lean_lib/lean_exe declaration recognised in {path}")
    if len(KEYWORD.findall(stripped)) != len(matches):
        raise Unrecognized(
            f"{path} mentions lean_lib/lean_exe {len(KEYWORD.findall(stripped))} time(s) but "
            f"{len(matches)} declaration(s) were recognised: unsupported syntax"
        )
    targets = []
    for match in matches:
        kind, name = match.group("kind"), match.group("name")
        label = f"{kind} {name}"
        body = _body_of(stripped, match)
        if re.search(r"\bglobs\s*:=", body):
            raise Unrecognized(f"{label}: `globs` is not supported")
        src_dir = os.path.normpath(_string_field(body, "srcDir", label))
        if kind == "lean_lib":
            roots = _names_field(body, "roots", label)
        else:
            roots = (_name_field(body, "root", label),)
        targets.append(Target(kind, name, src_dir, roots))
    return targets


def module_file(repo: Path, module: str, src_dirs: list[str]) -> Path | None:
    """The `.lean` file of `module` under one of the source directories, if there is one."""
    parts = module.split(".")
    for src_dir in src_dirs:
        candidate = repo.joinpath(src_dir, *parts[:-1], parts[-1] + ".lean")
        if candidate.is_file():
            return candidate
    return None


def imports_of(path: Path) -> list[str]:
    """Modules imported by the header of a Lean file (comments removed)."""
    tokens = strip_comments(path.read_text(encoding="utf-8")).split()
    modules: list[str] = []
    i = 0
    for keyword in ("module", "prelude"):
        if tokens[i : i + 1] == [keyword]:
            i += 1
    while True:
        j = i
        for modifier in ("public", "meta"):
            if tokens[j : j + 1] == [modifier]:
                j += 1
        if tokens[j : j + 1] != ["import"]:
            return modules
        j += 1
        if tokens[j : j + 1] == ["all"]:
            j += 1
        if j >= len(tokens):
            return modules
        modules.append(tokens[j])
        i = j + 1


def reachable_files(repo: Path, targets: list[Target]) -> set[Path]:
    """Files reachable from the declared roots through `import`."""
    src_dirs = sorted({target.src_dir for target in targets})
    pending: list[Path] = []
    for target in targets:
        for root in target.roots:
            found = module_file(repo, root, [target.src_dir])
            if found is None:
                raise Unrecognized(
                    f"{target.kind} {target.name}: root module {root} has no file under "
                    f"{target.src_dir}/"
                )
            pending.append(found)
    seen: set[Path] = set()
    while pending:
        current = pending.pop()
        if current in seen:
            continue
        seen.add(current)
        for module in imports_of(current):
            found = module_file(repo, module, src_dirs)
            if found is not None:
                pending.append(found)
    return seen


def scan(repo: Path, scan_dirs: list[str]) -> list[Path]:
    """Every `.lean` file under the scanned directories (the `.lake` directories excluded)."""
    files: list[Path] = []
    for scan_dir in scan_dirs:
        directory = repo / scan_dir
        if not directory.is_dir():
            raise Unrecognized(f"scanned directory {scan_dir}/ does not exist")
        files.extend(p for p in directory.rglob("*.lean") if ".lake" not in p.parts)
    return sorted(files)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument("--repo", default=".", help="repository root (default: current directory)")
    parser.add_argument("--dirs", nargs="+", default=list(DEFAULT_SCAN_DIRS), help="scanned dirs")
    parser.add_argument(
        "--roots-in",
        metavar="DIR",
        help="print the root modules of the targets whose srcDir is DIR, one per line, and exit",
    )
    args = parser.parse_args(argv)
    repo = Path(args.repo).resolve()
    try:
        targets = parse_lakefile(repo / "lakefile.lean")
        if args.roots_in is not None:
            wanted = os.path.normpath(args.roots_in)
            roots = sorted({root for t in targets if t.src_dir == wanted for root in t.roots})
            if not roots:
                raise Unrecognized(f"no lean_lib/lean_exe declares srcDir := {wanted!r}")
            print("\n".join(roots))
            return 0
        reachable = reachable_files(repo, targets)
        files = scan(repo, args.dirs)
    except Unrecognized as error:
        print(f"check_lean_modules: cannot analyse the repository: {error}", file=sys.stderr)
        return 2
    orphans = [path for path in files if path not in reachable]
    if orphans:
        print("check_lean_modules: Lean files that no lean_lib/lean_exe root reaches:")
        for path in orphans:
            print(f"  {path.relative_to(repo).as_posix()}")
        print(
            "`lake build` never compiles them. Import each one from a reachable module, or list "
            "it in the `roots` of a lean_lib of lakefile.lean."
        )
        return 1
    print(
        f"check_lean_modules: {len(files)} Lean file(s) under {', '.join(args.dirs)}, all "
        f"reachable from the {sum(len(t.roots) for t in targets)} root(s) of "
        f"{len(targets)} lean_lib/lean_exe target(s)."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
