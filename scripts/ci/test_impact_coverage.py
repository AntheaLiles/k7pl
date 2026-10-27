# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Guard: a file that a check reads must make the impact classifier run that check.

`impact.py` decides which CI surfaces run again for a pull request. A file that a check reads
but that does not trigger the check lets a pull request break the check without running it: the
failure then surfaces in a later, unrelated pull request. The routing tables of `impact.py` are
written by hand; this guard derives from the code of the checks which repository files they read,
and asks `impact.classify` whether each of them triggers the step that reads it.

What is analysed:

* Python entry points: `ENTRY_POINTS` lists, with the conditions of the steps that run them, the
  programs outside `scripts/ci/` that the impact-gated jobs of `verify.yaml` run; every module of
  `tests/python/` is an entry point of the pytest step (with `conftest.py`).
* Code reached from an entry point: local modules it imports (absolute or relative, anywhere in
  the file), resolved against the importing file's directory and every directory that the reached
  code adds to `sys.path`; and local `.py` files that it names through a resolved path (importlib,
  subprocess). The closure is followed transitively.
* Reads: path expressions anchored at `__file__` and built from literal segments:
  `Path(__file__)`, `.resolve()`, `.absolute()`, `.parent`, `.parents[k]`, `/ "literal"`,
  `.joinpath("literal", …)`, `.with_name("literal")`, through names assigned exactly once in the
  file. Only maximal expressions count: in `ROOT / "docs" / "x.md"` the read is `docs/x.md`, not
  `docs/`; a name used only to build other paths is not itself a read, and a name that the file
  never uses (a constant exported to other modules) is. Paths given to `sys.path` are import
  directories, not reads.
* Lean: the files reached through `import` from the targets that the `impl` and `spec` jobs build
  (`LEAN_TARGETS`).

Each file of the code closure and each file it reads must trigger the step: `impact.classify`
must set `full` or one of the surfaces of the step. A directory that is read is expanded to every
file under it.

Limits (this is a lower bound, not a proof that every read is covered):

* Paths built otherwise are not seen: strings relative to the working directory
  (`Path("wiki/STATUS.md")`, `open("lakefile.lean")`), f-strings, variables, globs, command-line
  arguments, environment variables, attributes of other modules, names assigned more than once.
* A directory read is expanded to all its files (hidden directories and `__pycache__` aside):
  the suffix filters and exclusions of the code are not seen, which can only over-approximate.
* The import closure over-approximates too: a module's reads are charged to every check that
  imports it, even through a function that the check never calls, and monkeypatching is not seen.
  The known cases are exempted in `EXEMPT_READS` and `EXEMPT_EDGES`, each with its reason; an
  exemption that no longer matches anything fails the guard.
* `scripts/ci/` is not an entry point: any change under it forces the complete validation, its
  `test_*.py` modules run on every pull request in the impact job, and its other scripts run in
  many jobs and workflows whose conditions are not modelled here. Its files are analysed only when
  an entry point reaches them.
* The step conditions are transcribed by hand in `ENTRY_POINTS` and `LEAN_TARGETS`. The workflow
  tests only check that `verify.yaml`, with the `scripts/ci/*.sh` step scripts that it runs, runs
  no other Python program outside `scripts/ci/` and builds no other Lake target; they do not parse
  its conditions.
"""

from __future__ import annotations

import ast
import functools
import os
import re
import tempfile
import textwrap
import unittest
from pathlib import Path

import check_lean_modules as lean
import impact

ROOT = Path(__file__).resolve().parents[2]
VERIFY = ROOT / ".github" / "workflows" / "verify.yaml"
PYTEST_DIR = "tests/python"

# A step runs when `full` or one of its surfaces is set; an entry point run by two steps must
# trigger both.
ENTRY_POINTS: dict[str, tuple[frozenset[str], ...]] = {
    # verify.yaml: job `quick`, step "Check the specification" (full || spec_check); job
    # `python-tests`, step "Check the real corpus with the tooling under test" (python_tests).
    "scripts/controle.py": (frozenset({"spec_check"}), frozenset({"python_tests"})),
}
# verify.yaml: job `python-tests`, step "Test the Python tooling": `pytest tests/python`.
PYTEST_STEPS = (frozenset({"python_tests"}),)

# Python files under scripts/ (outside scripts/ci/) that read repository files but that no
# impact-gated step runs.
# (Empty since the 2026-10-25 legacy triage deleted the frozen scripts/suivi.py
# together with its synthetic-corpus test; no other such file is known.)
NOT_RUN_BY_A_CHECK: dict[str, str] = {}

# (reader, path read): over-approximations of the analysis.
EXEMPT_READS = {
    ("scripts/controles/couverture.py", "wiki/STATUS.md"): (
        "default target of update_status(), a writer that only the `status` job of ci.yaml calls "
        "(through generate_status.py) after the CI gate; no check reads the file"
    ),
    ("tests/python/test_annotation_policy.py", ".github"): (
        "load(name) reads `.github/<name>` for the three problem-matcher and policy JSON files that "
        "the tests name, which are unclassified and force the full validation; the issue and pull "
        "request templates also under `.github/` are never read"
    ),
}
# (importer, imported): import edges that the closure must not follow.
# (Empty since the 2026-10-25 legacy triage deleted scripts/suivi.py and
# tests/python/test_suivi.py together.)
EXEMPT_EDGES = {}

# Lake targets that each job builds, by surface.
LEAN_TARGETS = {
    # verify.yaml, job `impl` (full || lean_build): `lake build K7pl K7plTests K7plCompliance
    # sbomAudit`, then `lake test` (the test driver, mainTest).
    "lean_build": ("K7pl", "K7plTests", "mainTest", "K7plCompliance", "sbomAudit"),
    # verify.yaml, job `spec` (full || spec_build): `lake build Spec`, `lake build K7plPrototypes`,
    # the axiom audits of SpecExt and SpecBib, `lake exe spec`.
    "spec_build": ("Spec", "K7plPrototypes", "SpecExt", "SpecBib", "spec"),
}

PATH_TYPES = {"Path", "PurePath", "PosixPath", "PurePosixPath"}
SAME_PATH_METHODS = {"resolve", "absolute"}
DERIVING_METHODS = SAME_PATH_METHODS | {"joinpath", "with_name"}


def _string(node: ast.AST) -> str | None:
    return node.value if isinstance(node, ast.Constant) and isinstance(node.value, str) else None


def _is_path_type(node: ast.AST) -> bool:
    if isinstance(node, ast.Name):
        return node.id in PATH_TYPES
    return isinstance(node, ast.Attribute) and node.attr in PATH_TYPES


def _is_sys_path(node: ast.AST) -> bool:
    return (
        isinstance(node, ast.Attribute)
        and node.attr == "path"
        and isinstance(node.value, ast.Name)
        and node.value.id == "sys"
    )


class FileAnalysis:
    """The paths that one Python file builds from `__file__`, resolved statically."""

    def __init__(self, path: Path):
        self.path = path
        self.tree = ast.parse(path.read_text(encoding="utf-8"), filename=str(path))
        self.parent_of = {
            child: node for node in ast.walk(self.tree) for child in ast.iter_child_nodes(node)
        }
        self.bindings: dict[str, Path] = {}
        self.binding_values: set[ast.AST] = set()
        self._bind()
        self.reads: list[tuple[Path, int]] = []
        self.import_dirs: set[Path] = set()
        self._collect()

    def _bind(self) -> None:
        """Resolve the names assigned exactly once (in any scope) to a path expression."""
        stores: dict[str, int] = {}
        for node in ast.walk(self.tree):
            if isinstance(node, ast.Name) and isinstance(node.ctx, (ast.Store, ast.Del)):
                stores[node.id] = stores.get(node.id, 0) + 1
            elif isinstance(node, ast.arg):
                stores[node.arg] = stores.get(node.arg, 0) + 1
        assigns = [
            node
            for node in ast.walk(self.tree)
            if isinstance(node, ast.Assign)
            and len(node.targets) == 1
            and isinstance(node.targets[0], ast.Name)
            and stores[node.targets[0].id] == 1
        ]
        changed = True
        while changed:
            changed = False
            for node in assigns:
                name = node.targets[0].id
                if name not in self.bindings:
                    value = self.value(node.value)
                    if value is not None:
                        self.bindings[name] = value
                        self.binding_values.add(node.value)
                        changed = True

    def value(self, node: ast.AST) -> Path | None:
        """The absolute path that `node` evaluates to, when it can be decided statically."""
        if isinstance(node, ast.Name):
            return self.bindings.get(node.id) if isinstance(node.ctx, ast.Load) else None
        if isinstance(node, ast.Call):
            func = node.func
            if _is_path_type(func) and len(node.args) == 1 and not node.keywords:
                arg = node.args[0]
                if isinstance(arg, ast.Name) and arg.id == "__file__":
                    return self.path
                return self.value(arg)
            if not isinstance(func, ast.Attribute) or node.keywords:
                return None
            base = self.value(func.value)
            segments = [_string(arg) for arg in node.args]
            if base is None or None in segments:
                return None
            if func.attr in SAME_PATH_METHODS and not segments:
                return base
            if func.attr == "joinpath":
                return Path(os.path.normpath(base.joinpath(*segments)))
            if func.attr == "with_name" and len(segments) == 1:
                return base.with_name(segments[0])
            return None
        if isinstance(node, ast.Attribute) and node.attr == "parent":
            base = self.value(node.value)
            return None if base is None else base.parent
        if isinstance(node, ast.Subscript) and isinstance(node.value, ast.Attribute):
            index = node.slice
            if node.value.attr == "parents" and isinstance(index, ast.Constant):
                base = self.value(node.value.value)
                if base is not None and isinstance(index.value, int) and 0 <= index.value < len(base.parents):
                    return base.parents[index.value]
            return None
        if isinstance(node, ast.BinOp) and isinstance(node.op, ast.Div):
            left, right = self.value(node.left), _string(node.right)
            if left is not None and right is not None:
                return Path(os.path.normpath(left / right))
        return None

    def _derived(self, node: ast.AST) -> ast.AST | None:
        """The enclosing expression that derives another path from `node`, if any."""
        parent = self.parent_of.get(node)
        if isinstance(parent, ast.BinOp) and isinstance(parent.op, ast.Div) and parent.left is node:
            return parent
        if isinstance(parent, ast.Attribute):
            grand = self.parent_of.get(parent)
            if parent.attr == "parent":
                return parent
            if parent.attr == "parents" and isinstance(grand, ast.Subscript):
                return grand
            if isinstance(grand, ast.Call) and grand.func is parent and parent.attr in DERIVING_METHODS:
                return grand
        if isinstance(parent, ast.Call) and _is_path_type(parent.func) and parent.args == [node]:
            return parent
        return None

    def _is_import_directory(self, node: ast.AST) -> bool:
        """`sys.path.insert(i, str(node))`, `sys.path.append(node)`, `str(node) in sys.path`."""
        parent = self.parent_of.get(node)
        if isinstance(parent, ast.Call) and isinstance(parent.func, ast.Name) and parent.func.id == "str":
            node, parent = parent, self.parent_of.get(parent)
        if isinstance(parent, ast.Call) and isinstance(parent.func, ast.Attribute):
            return _is_sys_path(parent.func.value) and parent.func.attr in {"insert", "append"}
        if isinstance(parent, ast.Compare):
            return any(_is_sys_path(side) for side in (parent.left, *parent.comparators))
        return False

    def _collect(self) -> None:
        loaded = {
            node.id
            for node in ast.walk(self.tree)
            if isinstance(node, ast.Name) and isinstance(node.ctx, ast.Load)
        }
        for node in ast.walk(self.tree):
            if not isinstance(node, ast.expr) or node in self.binding_values:
                continue
            value = self.value(node)
            if value is None:
                continue
            derived = self._derived(node)
            if derived is not None and self.value(derived) is not None:
                continue
            if self._is_import_directory(node):
                self.import_dirs.add(value)
            else:
                self.reads.append((value, node.lineno))
        for node in ast.walk(self.tree):
            if isinstance(node, ast.Assign) and node.value in self.binding_values:
                name = node.targets[0].id
                if name not in loaded:
                    self.reads.append((self.bindings[name], node.lineno))

    def imported_files(self, search_dirs: set[Path]) -> set[Path]:
        """Local `.py` files that the import statements of the file may load."""
        found: set[Path] = set()
        for node in ast.walk(self.tree):
            if isinstance(node, ast.Import):
                requests = [(alias.name, ()) for alias in node.names]
                bases = search_dirs | {self.path.parent}
            elif isinstance(node, ast.ImportFrom):
                requests = [(node.module or "", tuple(alias.name for alias in node.names))]
                if node.level:
                    bases = {self.path.parents[node.level - 1]}
                else:
                    bases = search_dirs | {self.path.parent}
            else:
                continue
            for module, names in requests:
                parts = [part for part in module.split(".") if part]
                for base in bases:
                    package = base.joinpath(*parts)
                    candidates = [package / "__init__.py"]
                    if parts:
                        candidates.append(package.with_suffix(".py"))
                    candidates += [package / f"{name}.py" for name in names]
                    found.update(path for path in candidates if path.is_file())
        return found


@functools.lru_cache(maxsize=None)
def analyse(path: Path) -> FileAnalysis:
    return FileAnalysis(path)


def relative(path: Path) -> str | None:
    """`path` relative to the repository, or None outside it (the root itself included)."""
    try:
        rel = path.relative_to(ROOT).as_posix()
    except ValueError:
        return None
    return None if rel == "." else rel


def in_scope(path: Path) -> bool:
    rel = relative(path)
    return rel is not None and rel.endswith(".py") and rel.startswith(("scripts/", f"{PYTEST_DIR}/"))


@functools.lru_cache(maxsize=None)
def expand(path: Path) -> tuple[str, ...]:
    """The repository files that reading `path` reads: a directory stands for its files."""
    rel = relative(path)
    if rel is None:
        return ()
    if not path.is_dir():
        return (rel,)
    files = []
    for directory, subdirs, names in os.walk(path):
        subdirs[:] = [d for d in subdirs if not d.startswith(".") and d != "__pycache__"]
        files += [relative(Path(directory) / name) for name in names if not name.startswith(".")]
    return tuple(sorted(files))


def closure(start: list[Path]) -> dict[Path, Path | None]:
    """Every in-scope file that `start` runs, mapped to the file that reached it."""
    reached: dict[Path, Path | None] = {}
    search_dirs: set[Path] = set()
    pending: list[tuple[Path, Path | None]] = [(path, None) for path in start]
    while pending:
        current, via = pending.pop(0)
        if current in reached:
            continue
        reached[current] = via
        analysis = analyse(current)
        search_dirs |= analysis.import_dirs
        executed = {path for path, _ in analysis.reads if path.suffix == ".py" and path.is_file()}
        for target in sorted(analysis.imported_files(search_dirs) | executed):
            if in_scope(target) and (relative(current), relative(target)) not in EXEMPT_EDGES:
                pending.append((target, current))
    return reached


def entry_points() -> dict[str, tuple[list[Path], tuple[frozenset[str], ...]]]:
    """Entry point -> (files loaded first, steps that run it)."""
    entries = {rel: ([ROOT / rel], steps) for rel, steps in ENTRY_POINTS.items()}
    conftest = ROOT / PYTEST_DIR / "conftest.py"
    for module in sorted((ROOT / PYTEST_DIR).glob("*.py")):
        entries[relative(module)] = ([conftest, module], PYTEST_STEPS)
    return entries


def triggers(path: str, step: frozenset[str]) -> bool:
    result = impact.classify([path])
    return bool(result["full"]) or any(result[surface] for surface in step)


def observed_reads():
    """(entry point, step, reader, line, path read, file read) for every analysed read."""
    for entry, (start, steps) in entry_points().items():
        for reader in closure(start):
            reader_rel = relative(reader)
            for path, line in analyse(reader).reads:
                for step in steps:
                    for read in expand(path):
                        yield entry, step, reader_rel, line, relative(path), read


def surfaces_of(path: str) -> str:
    """The flags that `path` sets, for failure messages."""
    result = impact.classify([path])
    flags = ("full", "docs_links", "spec_check", "spec_build", "lean_build", "python_tests", "tracking_views")
    return ",".join(key for key in flags if result[key]) or "nothing"


def lean_reachable(names: tuple[str, ...]) -> set[Path]:
    """Lean files reached from the roots of the named targets.

    Imports resolve against the source directories of every target, as Lake resolves them in
    the workspace, not only against those of the named targets.
    """
    targets = lean.parse_lakefile(ROOT / "lakefile.lean")
    src_dirs = sorted({target.src_dir for target in targets})
    chosen = [target for target in targets if target.name in names]
    missing = set(names) - {target.name for target in chosen}
    if missing:
        raise AssertionError(f"lakefile.lean declares no target named {sorted(missing)}")
    pending = [lean.module_file(ROOT, root, [t.src_dir]) for t in chosen for root in t.roots]
    if None in pending:
        raise AssertionError(f"a root of {', '.join(names)} has no file: run check_lean_modules.py")
    seen: set[Path] = set()
    while pending:
        current = pending.pop()
        if current is None or current in seen:
            continue
        seen.add(current)
        pending += [lean.module_file(ROOT, module, src_dirs) for module in lean.imports_of(current)]
    return seen


def step_scripts() -> list[Path]:
    """The `scripts/ci/*.sh` files that verify.yaml names: the shell of its steps."""
    names = re.findall(r"\bscripts/ci/[\w-]+\.sh\b", VERIFY.read_text(encoding="utf-8"))
    return [ROOT / name for name in sorted(set(names))]


def workflow_text() -> str:
    """verify.yaml and the step scripts that it runs, without their comment lines."""
    lines = VERIFY.read_text(encoding="utf-8").splitlines()
    for script in step_scripts():
        lines += script.read_text(encoding="utf-8").splitlines()
    return "\n".join(line for line in lines if not line.lstrip().startswith("#"))


class FileAnalysisTests(unittest.TestCase):
    """The resolver on small files: what it sees, and what it deliberately does not."""

    def analyse_source(self, source: str, rel: str = "scripts/sub/tool.py") -> FileAnalysis:
        tmp = tempfile.TemporaryDirectory()
        self.addCleanup(tmp.cleanup)
        path = Path(tmp.name) / rel
        path.parent.mkdir(parents=True)
        path.write_text(textwrap.dedent(source), encoding="utf-8")
        self.root = Path(tmp.name)
        return FileAnalysis(path)

    def reads(self, analysis: FileAnalysis) -> set[str]:
        return {path.relative_to(self.root).as_posix() for path, _ in analysis.reads}

    def test_anchored_chains_and_aliases_are_resolved(self):
        analysis = self.analyse_source(
            """
            from pathlib import Path
            ROOT = Path(__file__).resolve().parents[2]
            DOCS = ROOT / "docs" / "tracking"
            TABLE = DOCS / "table.csv"
            def main():
                TABLE.read_text()
                (DOCS / "view.md").write_text("")
                (ROOT.joinpath("spec", "Spec.lean")).read_text()
                Path(__file__).parent.parent.with_name("other").joinpath("x.json").read_text()
            """
        )
        self.assertEqual(
            self.reads(analysis),
            {"docs/tracking/table.csv", "docs/tracking/view.md", "spec/Spec.lean", "other/x.json"},
        )

    def test_a_name_only_used_as_a_base_is_not_read_but_an_unused_one_is(self):
        analysis = self.analyse_source(
            """
            from pathlib import Path
            ROOT = Path(__file__).resolve().parent.parent.parent
            BASE = ROOT / "docs"
            EXPORTED = ROOT / "docs" / "exported.md"
            USED = BASE / "used.md"
            print(USED)
            """
        )
        self.assertEqual(self.reads(analysis), {"docs/exported.md", "docs/used.md"})

    def test_paths_not_anchored_at_the_file_are_ignored(self):
        analysis = self.analyse_source(
            """
            import os
            from pathlib import Path
            def f(root, tmp_path):
                (root / "docs" / "c.md").read_text()
                (tmp_path / "docs" / "d.md").read_text()
                Path("docs/e.md").read_text()
                open(os.path.join("docs", "f.md"))
            """
        )
        self.assertEqual(self.reads(analysis), set())

    def test_a_name_assigned_twice_is_not_resolved(self):
        analysis = self.analyse_source(
            """
            from pathlib import Path
            AGAIN = Path(__file__).parent / "a.md"
            AGAIN = Path(__file__).parent / "b.md"
            AGAIN.read_text()
            (AGAIN / "c.md").read_text()
            """
        )
        # Each literal expression is still a read; the uses of the ambiguous name are not.
        self.assertEqual(self.reads(analysis), {"scripts/sub/a.md", "scripts/sub/b.md"})

    def test_an_unresolved_segment_reads_the_resolved_prefix_as_a_directory(self):
        analysis = self.analyse_source(
            """
            from pathlib import Path
            DATA = Path(__file__).parent / "data"
            def load(name):
                return (DATA / name).read_text() + (DATA / f"{name}.json").read_text()
            """
        )
        self.assertEqual(self.reads(analysis), {"scripts/sub/data"})

    def test_sys_path_entries_are_import_directories(self):
        analysis = self.analyse_source(
            """
            import sys
            from pathlib import Path
            SCRIPTS = Path(__file__).resolve().parents[1]
            if str(SCRIPTS) not in sys.path:
                sys.path.insert(0, str(SCRIPTS))
            sys.path.append(str(Path(__file__).parent / "lib"))
            """
        )
        self.assertEqual(self.reads(analysis), set())
        self.assertEqual(
            {path.relative_to(self.root).as_posix() for path in analysis.import_dirs},
            {"scripts", "scripts/sub/lib"},
        )

    def test_local_imports_are_resolved(self):
        analysis = self.analyse_source(
            """
            import json
            import helper
            from pkg import mod
            from . import sibling
            """
        )
        sub = self.root / "scripts" / "sub"
        for rel in ("helper.py", "pkg/__init__.py", "pkg/mod.py", "sibling.py"):
            (sub / rel).parent.mkdir(parents=True, exist_ok=True)
            (sub / rel).write_text("", encoding="utf-8")
        found = {path.relative_to(sub).as_posix() for path in analysis.imported_files(set())}
        self.assertEqual(found, {"helper.py", "pkg/__init__.py", "pkg/mod.py", "sibling.py"})


class ReadCoverageTests(unittest.TestCase):
    """Every file that a check runs or reads triggers that check."""

    def test_every_file_a_check_reads_triggers_it(self):
        failures = set()
        for entry, step, reader, line, path, read in observed_reads():
            if (reader, path) in EXEMPT_READS or triggers(read, step):
                continue
            failures.add(
                f"{read} (read by {reader}:{line}, run by {entry}) triggers {surfaces_of(read)}, "
                f"not {' or '.join(sorted(step))}"
            )
        self.assertFalse(
            failures,
            "files read by a check that do not trigger it; route them in scripts/ci/impact.py "
            "(or exempt the read with its reason here):\n  " + "\n  ".join(sorted(failures)),
        )

    def test_the_code_a_check_runs_triggers_it(self):
        failures = set()
        for entry, (start, steps) in entry_points().items():
            for code in closure(start):
                for step in steps:
                    rel = relative(code)
                    if not triggers(rel, step):
                        failures.add(
                            f"{rel} (run by {entry}) triggers {surfaces_of(rel)}, "
                            f"not {' or '.join(sorted(step))}"
                        )
        message = ["code that a check runs but that does not trigger it:", *sorted(failures)]
        self.assertFalse(failures, "\n  ".join(message))

    def test_every_python_file_that_reads_the_repository_is_run_by_a_check(self):
        reached = {
            relative(path) for start, _ in entry_points().values() for path in closure(start)
        }
        candidates = [*sorted((ROOT / "scripts").rglob("*.py")), *sorted((ROOT / PYTEST_DIR).glob("*.py"))]
        orphans = []
        for path in candidates:
            rel = relative(path)
            if rel.startswith("scripts/ci/") or "__pycache__" in path.parts:
                continue
            if any(expand(read) for read, _ in analyse(path).reads) and rel not in reached:
                if rel not in NOT_RUN_BY_A_CHECK:
                    orphans.append(rel)
        self.assertEqual(
            orphans, [], "these files read repository files but no entry point runs them: add the "
            "step that runs them to ENTRY_POINTS, or explain in NOT_RUN_BY_A_CHECK why none does"
        )
        for rel in NOT_RUN_BY_A_CHECK:
            self.assertTrue((ROOT / rel).is_file(), f"stale NOT_RUN_BY_A_CHECK entry: {rel}")
            self.assertNotIn(rel, reached, f"{rel} is run by a check now: drop it from NOT_RUN_BY_A_CHECK")

    def test_exemptions_still_match_something(self):
        reads = {(reader, path) for _, _, reader, _, path, _ in observed_reads()}
        for key in EXEMPT_READS:
            self.assertIn(key, reads, f"stale EXEMPT_READS entry: {key}")
        for importer, imported in EXEMPT_EDGES:
            analysis = analyse(ROOT / importer)
            targets = analysis.imported_files({ROOT / "scripts"}) | {p for p, _ in analysis.reads}
            self.assertIn(ROOT / imported, targets, f"stale EXEMPT_EDGES entry: {importer} -> {imported}")

    def test_the_analysis_is_not_vacuous(self):
        """Reads that the audit found by hand: if the resolver stops seeing them, it is broken."""
        seen = {(entry, reader, read) for entry, _, reader, _, _, read in observed_reads()}
        expected = {
            ("tests/python/test_statement_inventory.py", "scripts/controles/statement_inventory.py",
             "wiki/assurance.md"),
            ("scripts/controle.py", "scripts/controles/couverture.py", "src/K7pl.lean"),
        }
        self.assertEqual(expected - seen, set())
        self.assertGreater(len(seen), 200)
        controle = closure([ROOT / "scripts" / "controle.py"])
        self.assertIn(ROOT / "scripts" / "controles" / "couverture.py", controle)


class WorkflowConsistencyTests(unittest.TestCase):
    """The hand-written step tables still name what verify.yaml runs."""

    def test_python_entry_points_are_the_programs_the_workflow_runs(self):
        named = set(re.findall(r"\bscripts/(?!ci/)[\w./-]+\.py\b", workflow_text()))
        self.assertEqual(named, set(ENTRY_POINTS))
        self.assertRegex(workflow_text(), rf"pytest {re.escape(PYTEST_DIR)}\b")

    def test_lake_targets_are_the_ones_the_workflow_builds(self):
        declared = {target.name for target in lean.parse_lakefile(ROOT / "lakefile.lean")}
        text = workflow_text()
        named = set()
        for args in re.findall(r"\blake build((?: [\w.]+)+)", text):
            named.update(args.split())
        named.update(re.findall(r"\blake exe (\w+)", text))
        for args in re.findall(r"scripts/axiom-audit\.sh \S+((?: [\w.]+)+)", text):
            named.update(args.split())
        # The Deno axiom-audit replacement names each root directly instead of passing
        # roots through scripts/axiom-audit.sh. Count those roots in the same coverage set.
        for root in re.findall(r"axiom_audit\.ts audit (\S+)", text):
            named.add(root.split(".", maxsplit=1)[0])
        if re.search(r"\blake test\b", text):
            named.add("mainTest")
        known = {name for names in LEAN_TARGETS.values() for name in names}
        self.assertEqual(
            (named & declared) - known, set(), "verify.yaml builds a Lake target missing from LEAN_TARGETS"
        )
        self.assertEqual(known - named, set(), "LEAN_TARGETS names a target that verify.yaml does not build")

    def test_the_step_scripts_are_read_with_the_workflow(self):
        scripts = {path.relative_to(ROOT).as_posix() for path in step_scripts()}
        text = workflow_text()
        # The shell entry point remains in-tree, but its orchestration has moved
        # to Deno. Test that it is preserved separately from the active step list.
        self.assertTrue((ROOT / "scripts/ci/verify_sbom_audit.sh").is_file())
        self.assertIn("tools/ci-controller/src/lake_to_spdx.ts", text)
        self.assertIn("tools/ci-controller/src/sbom_evidence.ts", text)
        # Axiom audits have been ported to Deno; the old shell entry point was
        # removed once the full CI cycle was green. Verify the replacement steps
        # are wired.
        self.assertIn("tools/ci-controller/src/axiom_audit.ts audit-roots tools Compliance", text)
        self.assertIn("tools/ci-controller/src/axiom_audit.ts audit-roots tests", text)
        for path in step_scripts():
            self.assertTrue(path.is_file(), f"verify.yaml runs {path}, which does not exist")
        self.assertIn("lake exe sbomAudit lake-manifest.json", text)


class LeanCoverageTests(unittest.TestCase):
    def test_every_lean_file_a_job_builds_triggers_it(self):
        failures = []
        for surface, names in LEAN_TARGETS.items():
            for path in sorted(lean_reachable(names)):
                rel = relative(path)
                if not triggers(rel, frozenset({surface})):
                    failures.append(
                        f"{rel} (built from {', '.join(names)}) triggers {surfaces_of(rel)}, not {surface}"
                    )
        message = ["Lean files that do not trigger the job that builds them:", *failures]
        self.assertEqual(failures, [], "\n  ".join(message))

    def test_the_lean_analysis_is_not_vacuous(self):
        impl = {relative(path) for path in lean_reachable(LEAN_TARGETS["lean_build"])}
        expected = {
            "tools/SpecExt/IndexTerms.lean",
            "tools/Compliance/SbomAuditMain.lean",
            "tests/MainTest.lean",
        }
        self.assertEqual(expected - impl, set())
        spec = {relative(path) for path in lean_reachable(LEAN_TARGETS["spec_build"])}
        self.assertTrue({"spec/Spec.lean", "tools/SpecMain.lean", "tools/SpecBib.lean"} <= spec)


if __name__ == "__main__":
    unittest.main()
