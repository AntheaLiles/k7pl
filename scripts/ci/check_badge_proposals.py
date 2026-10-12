#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Check local BadgeApp source coherence and generate explicitly approved proposal URLs.

This tool never writes to BadgeApp. Upstream criterion changes are reported, never applied.
"""

from __future__ import annotations

import argparse
import json
import re
import sys
import urllib.error
import urllib.parse
import urllib.request
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
REGISTRY_PATH = Path(__file__).with_name("badge_criteria_registry.json")
REPOSITORY_URL = "https://github.com/AntheaLiles/k7pl"
PROJECT_URL = "https://anthealiles.github.io/k7pl/"
PROJECT_ID = "15239"
BADGE_URL = f"https://www.bestpractices.dev/projects/{PROJECT_ID}/badge"
BADGE_LINK = f"https://www.bestpractices.dev/projects/{PROJECT_ID}"
UPSTREAM_API = "https://api.github.com/repos/ossf/best-practices-badge/contents"
METADATA_FIELDS = frozenset({"name", "description", "license", "implementation_languages"})
STATUSES = frozenset({"Met", "Unmet", "N/A"})
SHA_RE = re.compile(r"[0-9a-f]{40}")
SECTIONS = frozenset({"passing", "silver", "gold", "baseline-1", "baseline-2", "baseline-3"})
BADGE_RE = re.compile(r"\[!\[OpenSSF Best Practices\]\(([^)\s]+)\)\]\(([^)\s]+)\)")


class ProposalError(ValueError):
    """Invalid or insufficiently reviewed proposal."""


def utc_now() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")


def load_json(path: Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        raise ProposalError(f"cannot read JSON file {path}: {error}") from error


def load_registry(path: Path = REGISTRY_PATH) -> dict[str, Any]:
    registry = load_json(path)
    source, sections = registry.get("source"), registry.get("sections")
    if registry.get("schema_version") != 1 or not isinstance(source, dict) or not isinstance(sections, dict):
        raise ProposalError("invalid criterion registry header")
    if source.get("repository") != "ossf/best-practices-badge" or not SHA_RE.fullmatch(str(source.get("commit", ""))):
        raise ProposalError("criterion registry source is not pinned to the expected upstream")
    for kind in ("metal", "baseline"):
        item = source.get(kind)
        if not isinstance(item, dict) or not SHA_RE.fullmatch(str(item.get("blob_sha", ""))):
            raise ProposalError(f"missing pinned SHA for {kind} criteria")
    if set(sections) != SECTIONS:
        raise ProposalError("registry must contain passing, silver, gold and baseline-1/2/3")
    for section, criteria in sections.items():
        if not isinstance(criteria, dict) or not criteria:
            raise ProposalError(f"empty or invalid registry section: {section}")
        for identifier, props in criteria.items():
            if not re.fullmatch(r"[A-Za-z][A-Za-z0-9_]*", identifier) or not isinstance(props, dict):
                raise ProposalError(f"invalid criterion registry item: {section}/{identifier}")
            for key in ("na_allowed", "na_justification_required", "met_justification_required",
                        "met_url_required", "future", "obsolete"):
                if not isinstance(props.get(key), bool):
                    raise ProposalError(f"invalid {key} flag for {section}/{identifier}")
    return registry


def cff_scalar(text: str, key: str) -> str | None:
    pattern = re.compile(r"^" + re.escape(key) + r':\s*(?:"([^"]*)"|\'([^\']*)\'|([^#\s][^#]*?))\s*(?:#.*)?$')
    for line in text.splitlines():
        match = pattern.match(line)
        if match:
            return next((part for part in match.groups() if part is not None), "").strip()
    return None


def check_source_coherence(root: Path = ROOT) -> list[str]:
    """Check stable URLs without inferring unresolved project identity or licence metadata."""
    try:
        cff = (root / "CITATION.cff").read_text(encoding="utf-8")
        readme = (root / "README.md").read_text(encoding="utf-8")
    except OSError as error:
        return [f"cannot read repository metadata: {error}"]
    errors = []
    if cff_scalar(cff, "repository-code") != REPOSITORY_URL:
        errors.append(f"CITATION.cff repository-code must equal {REPOSITORY_URL}")
    if cff_scalar(cff, "url") != PROJECT_URL:
        errors.append(f"CITATION.cff url must equal {PROJECT_URL}")
    badges = BADGE_RE.findall(readme)
    if len(badges) != 1:
        errors.append(f"README.md must contain exactly one Best Practices badge; found {len(badges)}")
    elif badges[0] != (BADGE_URL, BADGE_LINK):
        errors.append("README.md Best Practices badge URLs do not match project 15239")
    try:
        load_registry()
    except ProposalError as error:
        errors.append(str(error))
    return errors


def evidence_url(item: object, source_sha: str, root: Path) -> str:
    if not isinstance(item, str) or not item.strip():
        raise ProposalError("evidence items must be non-empty strings")
    value = item.strip()
    if value.startswith("https://"):
        parsed = urllib.parse.urlsplit(value)
        if not parsed.hostname or parsed.username or parsed.password:
            raise ProposalError(f"evidence URL is not a safe HTTPS URL: {value!r}")
        return value
    if "://" in value or value.startswith(("/", "\\")) or "\\" in value:
        raise ProposalError(f"evidence must be HTTPS or a repository-relative file: {value!r}")
    path = Path(value)
    if any(part in {"", ".", ".."} for part in path.parts):
        raise ProposalError(f"evidence path is not normalized: {value!r}")
    resolved = (root / path).resolve()
    try:
        relative = resolved.relative_to(root.resolve())
    except ValueError as error:
        raise ProposalError(f"evidence path escapes repository: {value!r}") from error
    if not resolved.is_file():
        raise ProposalError(f"evidence file does not exist: {value!r}")
    return f"{REPOSITORY_URL}/blob/{source_sha}/{urllib.parse.quote(relative.as_posix(), safe='/')}"


def exact_keys(value: object, expected: set[str], context: str) -> dict[str, Any]:
    if not isinstance(value, dict):
        raise ProposalError(f"{context} must be an object")
    extra, missing = set(value) - expected, expected - set(value)
    if extra:
        names = ", ".join(sorted(str(key) for key in extra))
        if "overrides" in extra or "reanalyze" in extra:
            raise ProposalError(f"{context} contains forbidden BadgeApp control parameter(s): {names}")
        raise ProposalError(f"{context} contains unsupported key(s): {names}")
    if missing:
        raise ProposalError(f"{context} is missing key(s): {', '.join(sorted(missing))}")
    return value


def build_proposal_url(proposal: object, root: Path = ROOT,
                       registry: dict[str, Any] | None = None) -> str:
    data = exact_keys(proposal, {"schema_version", "section", "source_sha", "human_reviewed", "metadata", "criteria"}, "proposal")
    if data["schema_version"] != 1:
        raise ProposalError("schema_version must be 1")
    section = data["section"]
    if section not in SECTIONS:
        raise ProposalError(f"unsupported BadgeApp section: {section!r}")
    if data["human_reviewed"] is not True:
        raise ProposalError("human_reviewed must be true before generating a proposal URL")
    source_sha = data["source_sha"]
    if not isinstance(source_sha, str) or not SHA_RE.fullmatch(source_sha):
        raise ProposalError("source_sha must be a full Git commit SHA")
    registry = registry or load_registry()
    section_criteria = registry["sections"][section]
    metadata, criteria = data["metadata"], data["criteria"]
    if not isinstance(metadata, dict) or not isinstance(criteria, dict) or not (metadata or criteria):
        raise ProposalError("metadata and criteria must be objects and at least one must contain a proposal")

    params: dict[str, str] = {}
    for field, raw in metadata.items():
        if field not in METADATA_FIELDS:
            raise ProposalError(f"unsupported metadata field: {field!r}")
        record = exact_keys(raw, {"value", "approved", "evidence"}, f"metadata.{field}")
        if record["approved"] is not True:
            raise ProposalError(f"metadata.{field} requires explicit human approval")
        value, evidence = record["value"], record["evidence"]
        if not isinstance(value, str) or not value.strip():
            raise ProposalError(f"metadata.{field}.value must be non-empty")
        if not isinstance(evidence, list) or not evidence:
            raise ProposalError(f"metadata.{field} requires evidence")
        for item in evidence:
            evidence_url(item, source_sha, root)  # The reviewed manifest remains the evidence ledger.
        # Only documented non-criteria fields are sent for metadata.
        params[field] = value.strip()

    for identifier, raw in criteria.items():
        if not isinstance(identifier, str) or not re.fullmatch(r"[A-Za-z][A-Za-z0-9_]*", identifier):
            raise ProposalError(f"invalid criterion identifier: {identifier!r}")
        record = exact_keys(raw, {"status", "justification", "approved", "evidence"}, f"criteria.{identifier}")
        definition = section_criteria.get(identifier)
        if definition is None:
            raise ProposalError(f"criterion {identifier!r} is not defined for section {section!r} in the pinned registry")
        if definition["future"] or definition["obsolete"]:
            raise ProposalError(f"criterion {identifier!r} is marked future or obsolete")
        status = record["status"]
        if status not in STATUSES:
            raise ProposalError(f"criteria.{identifier}.status must be exactly one of {sorted(STATUSES)}")
        if status == "N/A" and not definition["na_allowed"]:
            raise ProposalError(f"criterion {identifier!r} does not permit N/A in section {section!r}")
        if record["approved"] is not True:
            raise ProposalError(f"criteria.{identifier} requires explicit human approval")
        justification, evidence = record["justification"], record["evidence"]
        if not isinstance(justification, str) or not justification.strip():
            raise ProposalError(f"criteria.{identifier}.justification must be non-empty")
        if not isinstance(evidence, list) or not evidence:
            raise ProposalError(f"criteria.{identifier} requires evidence")
        links = [evidence_url(item, source_sha, root) for item in evidence]
        if status == "Met" and definition["met_url_required"] and not any(link.startswith("https://") for link in links):
            raise ProposalError(f"criterion {identifier!r} requires URL evidence for Met")
        params[f"{identifier}_status"] = status
        params[f"{identifier}_justification"] = justification.strip() + " Evidence: " + ", ".join(links)

    query = urllib.parse.urlencode(sorted(params.items()))
    result = f"https://www.bestpractices.dev/en/projects/{PROJECT_ID}/{section}/edit?{query}"
    if len(result) > 6000:
        raise ProposalError("proposal URL exceeds 6000 characters; reduce fields or shorten public evidence URLs")
    return result


def get_upstream_blob_sha(path: str, opener=urllib.request.urlopen) -> str:
    url = f"{UPSTREAM_API}/{urllib.parse.quote(path, safe='/')}?ref=main"
    request = urllib.request.Request(url, headers={
        "Accept": "application/vnd.github+json",
        "User-Agent": "k7pl-badge-evidence-check/1.0",
    })
    with opener(request, timeout=15) as response:
        payload = json.loads(response.read().decode("utf-8"))
    sha = payload.get("sha") if isinstance(payload, dict) else None
    if not isinstance(sha, str) or not SHA_RE.fullmatch(sha):
        raise OSError(f"GitHub Contents API returned no valid blob SHA for {path}")
    return sha


def upstream_drift_report(registry: dict[str, Any] | None = None, opener=urllib.request.urlopen) -> dict[str, Any]:
    registry = registry or load_registry()
    checks, errors, drift = [], [], []
    for kind in ("metal", "baseline"):
        source = registry["source"][kind]
        try:
            observed = get_upstream_blob_sha(source["path"], opener=opener)
        except (OSError, ValueError, urllib.error.URLError, TimeoutError) as error:
            errors.append({"path": source["path"], "error": str(error)})
            continue
        item = {"path": source["path"], "expected_blob_sha": source["blob_sha"], "observed_blob_sha": observed}
        checks.append(item)
        if source["blob_sha"] != observed:
            drift.append(item)
    status = "unavailable" if errors else "drift" if drift else "unchanged"
    return {
        "schema_version": 1, "checked_at_utc": utc_now(),
        "registry_snapshot_date": registry.get("snapshot_date"),
        "upstream_repository": registry["source"]["repository"],
        "upstream_commit_at_snapshot": registry["source"]["commit"],
        "status": status, "checks": checks, "drift": drift, "errors": errors,
        "policy": "Report only. The pinned registry is never updated automatically.",
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    modes = parser.add_mutually_exclusive_group(required=True)
    modes.add_argument("--check-sources", action="store_true")
    modes.add_argument("--check-upstream", action="store_true")
    modes.add_argument("--proposal", type=Path)
    parser.add_argument("--report", type=Path, help="JSON report destination for --check-upstream")
    args = parser.parse_args(argv)
    try:
        if args.check_sources:
            errors = check_source_coherence()
            if errors:
                for error in errors:
                    print(f"ERROR: {error}", file=sys.stderr)
                return 1
            counts = {key: len(value) for key, value in load_registry()["sections"].items()}
            print("Badge source coherence: PASS")
            print("Pinned criteria counts: " + ", ".join(f"{key}={value}" for key, value in counts.items()))
            print("No metadata or criterion status is inferred or submitted by this check.")
            return 0
        if args.proposal:
            print(build_proposal_url(load_json(args.proposal)))
            print("Review the proposal in BadgeApp; this URL does not save any changes.", file=sys.stderr)
            return 0
        report = upstream_drift_report()
        if args.report:
            args.report.parent.mkdir(parents=True, exist_ok=True)
            args.report.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        print(json.dumps(report, ensure_ascii=False, indent=2))
        if report["status"] == "drift":
            print("::warning::OpenSSF BadgeApp criteria changed upstream; review and update the registry manually.")
            return 1
        if report["status"] == "unavailable":
            print("::warning::Could not verify OpenSSF BadgeApp criteria drift; inspect the report and retry.")
            return 2
        return 0
    except ProposalError as error:
        print(f"ERROR: {error}", file=sys.stderr)
        return 1
    except OSError as error:
        print(f"ERROR: {error}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
