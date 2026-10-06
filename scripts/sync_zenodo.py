#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Publish the PDF of a GitHub release to Zenodo, as a new version of a declared concept record.

Adapted from the quickViz synchronisation script. A Zenodo DOI cannot be withdrawn, so the script
fails by default: it refuses to run, before any network call, unless every input below is present
and well formed. In particular it never falls back to a default Zenodo instance and never creates
a new record unless that is asked for explicitly.

Inputs:
  zenodo.json           metadata shared by every record; required, must be a JSON object with a
                        non-empty `creators` (a missing, empty or invalid file is an error, never `{}`)
  zenodo.files.json     per-file metadata, keyed by "<ZENODO_FILES_DIR>/<name>.pdf"; optional, but
                        an empty or invalid file is an error

Environment (all required unless stated otherwise):
  ZENODO_TOKEN          personal access token (scopes: deposit:write, deposit:actions); not needed
                        by --check-config. Assumed to be printable ASCII without a space (an assumption
                        about the token format, not checked against Zenodo): anything else is refused
                        before the network, without being shown.
  ZENODO_ENV            exactly "production" or "sandbox"; no default
  ZENODO_CONCEPT_RECID  the concept record id (the number of the concept DOI 10.5281/zenodo.<id>)
                        under which a new version is published, or the literal "NEW" to create a
                        new record and a new concept DOI on purpose
  ZENODO_TAG            release tag, "spec-v<version>"
  ZENODO_COMMIT         40-hex SHA of the tagged commit
  ZENODO_REPOSITORY     "<owner>/<repository>" of the release
  ZENODO_RELEASE_URL    URL of the GitHub release, under https://github.com/<repository>/releases/
  ZENODO_VERSION        optional; when set it must equal the tag without its "spec-v" prefix
  ZENODO_FILES_DIR      directory of the PDF to publish (default: "out"); it must hold exactly one
  GITHUB_RUN_ATTEMPT    required to be exactly "1" when ZENODO_CONCEPT_RECID is NEW (set by GitHub
                        Actions; a "Re-run" increments it)
  GITHUB_STEP_SUMMARY   optional, receives a Markdown summary of the published DOIs

At run time, without editing zenodo.json, the record receives related identifiers for the tag, the
commit and the release, and the SHA-256 of the PDF in its notes. When Zenodo reports a checksum for
the uploaded file, it is compared with the local file before anything is published.

A release is archived once: when the latest version of the declared concept already carries the
related identifier of this tag, the script refuses. It cannot make that check for NEW, so a run
with NEW must never be repeated: set ZENODO_CONCEPT_RECID from the job summary first. That is
why NEW also refuses to run unless GITHUB_RUN_ATTEMPT is "1".

Once the publish request has been sent, nothing may hide the result: any later failure (an
unexpected link or answer, a lost connection, an interrupt) still prints the identifiers and writes
the job summary, with the instruction not to re-run, and exits with status 3 (an interrupt is
re-raised after the report). A publish request whose answer is lost, or that Zenodo answered other
than with 400, 401, 403, 404 or 422, is reported as an uncertain publication.

Exit status: 0 published; 1 refused or failed before the publish request; 2 invalid configuration
(before any network call); 3 failed after, or during, the publish request.

Usage:
  scripts/sync_zenodo.py                 publish
  scripts/sync_zenodo.py --check-config  validate the environment only (no token, no network)
"""

from __future__ import annotations

import argparse
import glob
import hashlib
import json
import os
import re
import sys
from collections.abc import Mapping
from dataclasses import dataclass, field
from datetime import date
from urllib.parse import urlsplit

import requests

ENVIRONMENTS = {"production": "https://zenodo.org", "sandbox": "https://sandbox.zenodo.org"}
NEW_CONCEPT = "NEW"
TIMEOUT = 120

ID_RE = re.compile(r"[1-9][0-9]{0,17}")
FILE_ID_RE = re.compile(r"[A-Za-z0-9][A-Za-z0-9_-]{0,127}")
SHA1_RE = re.compile(r"[0-9a-f]{40}")
REPOSITORY_RE = re.compile(r"[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+")
VERSION_RE = re.compile(r"[0-9A-Za-z][0-9A-Za-z.+_-]*")
TAG_PREFIX = "spec-v"
# A token is printable ASCII without a space: a pasted secret that ends with a line break would
# otherwise be rejected by `requests` with a message that contains the whole header value.
TOKEN_RE = re.compile(r"[\x21-\x7e]+")
# Answers to the publish request that prove nothing was published. Any other failure (408, 409, 429,
# 5xx, a lost connection) leaves the publication uncertain.
CLEAR_REFUSALS = frozenset({400, 401, 403, 404, 422})


class ConfigError(Exception):
    """An input is missing or malformed; raised before any network call."""


class ZenodoError(Exception):
    """Zenodo answered with something the script refuses to act on."""


@dataclass(frozen=True)
class Config:
    """The validated inputs of one run."""

    env: str
    token: str | None = field(repr=False)
    concept: int | None  # None: create a new record (ZENODO_CONCEPT_RECID=NEW)
    version: str
    tag: str
    commit: str
    repository: str
    release_url: str
    files_dir: str

    @property
    def base_url(self) -> str:
        return ENVIRONMENTS[self.env]

    @property
    def api(self) -> str:
        return f"{self.base_url}/api"

    @property
    def headers(self) -> dict[str, str]:
        return {"Authorization": f"Bearer {self.token}"}


def load_config(environ: Mapping[str, str], require_token: bool = True) -> Config:
    """Validate the environment. Nothing here touches the network."""
    env = environ.get("ZENODO_ENV", "")
    if env not in ENVIRONMENTS:
        raise ConfigError(
            f"ZENODO_ENV must be exactly 'production' or 'sandbox', got {env!r}. "
            "There is deliberately no default: a DOI published on the wrong instance is irreversible."
        )

    raw = environ.get("ZENODO_CONCEPT_RECID", "")
    if raw == "":
        raise ConfigError(
            "ZENODO_CONCEPT_RECID is not set. Set it to the concept record id under which a new "
            "version must be published, or to NEW to create a new record and a new concept DOI. "
            "Which one is right is the author's decision: nothing in the repository proves where "
            "the DOI 10.5281/zenodo.23040451 comes from."
        )
    if raw == NEW_CONCEPT:
        concept = None
        # A "Re-run" of a workflow run keeps its run id and increments GITHUB_RUN_ATTEMPT. NEW has no
        # way to notice that its record already exists, so a second attempt would mint a second
        # concept DOI.
        attempt = environ.get("GITHUB_RUN_ATTEMPT")
        if attempt != "1":
            raise ConfigError(
                f"ZENODO_CONCEPT_RECID=NEW creates a new concept DOI and must never be repeated, but "
                f"GITHUB_RUN_ATTEMPT is {attempt!r}, not '1' (a 'Re-run' increments it). Set "
                "ZENODO_CONCEPT_RECID to the concept record id given by the summary of the first "
                "attempt, then publish again with a new release or from a fresh run."
            )
    elif ID_RE.fullmatch(raw):
        concept = int(raw)
    else:
        raise ConfigError(
            f"ZENODO_CONCEPT_RECID must be a positive integer or the literal NEW, got {raw!r}."
        )

    tag = environ.get("ZENODO_TAG", "")
    if not tag.startswith(TAG_PREFIX) or not VERSION_RE.fullmatch(tag[len(TAG_PREFIX):]):
        raise ConfigError(f"ZENODO_TAG must look like 'spec-v<version>', got {tag!r}.")
    version = tag[len(TAG_PREFIX):]
    declared_version = environ.get("ZENODO_VERSION", "")
    if declared_version and declared_version != version:
        raise ConfigError(f"ZENODO_VERSION {declared_version!r} does not match the tag {tag!r}.")

    commit = environ.get("ZENODO_COMMIT", "")
    if not SHA1_RE.fullmatch(commit):
        raise ConfigError(f"ZENODO_COMMIT must be 40 lowercase hexadecimal digits, got {commit!r}.")

    repository = environ.get("ZENODO_REPOSITORY", "")
    if not REPOSITORY_RE.fullmatch(repository):
        raise ConfigError(f"ZENODO_REPOSITORY must be '<owner>/<repository>', got {repository!r}.")

    release_url = environ.get("ZENODO_RELEASE_URL", "")
    if not release_url.startswith(f"https://github.com/{repository}/releases/") or any(
        c.isspace() for c in release_url
    ):
        raise ConfigError(
            f"ZENODO_RELEASE_URL must be under https://github.com/{repository}/releases/, "
            f"got {release_url!r}."
        )

    token = environ.get("ZENODO_TOKEN") or None
    if require_token and token is None:
        raise ConfigError("ZENODO_TOKEN is not set.")
    if token is not None and not TOKEN_RE.fullmatch(token):
        raise ConfigError(
            "ZENODO_TOKEN contains a space, a line break or a non-printable character (a pasted "
            "secret often ends with a newline). The value is not shown."
        )

    return Config(
        env=env,
        token=token,
        concept=concept,
        version=version,
        tag=tag,
        commit=commit,
        repository=repository,
        release_url=release_url,
        files_dir=environ.get("ZENODO_FILES_DIR") or "out",
    )


def load_json_object(path, required):
    """The JSON object stored in `path`.

    A missing file is acceptable only when it is not `required`. An empty, unreadable or invalid
    file never is: falling back to `{}` would send Zenodo, and fix forever in a DOI, metadata that
    nobody wrote.
    """
    if not os.path.exists(path):
        if required:
            raise ConfigError(f"{path} is missing: it holds the metadata of the record.")
        return {}
    try:
        with open(path, encoding="utf-8") as f:
            data = json.load(f)
    except (OSError, UnicodeDecodeError, json.JSONDecodeError) as error:
        raise ConfigError(f"{path} is empty or is not valid JSON: {error}") from error
    if not isinstance(data, dict):
        raise ConfigError(f"{path} must hold a JSON object.")
    return data


def quote(text: str) -> str:
    """`text` as inert log lines: non-printable characters replaced, every line prefixed so that none
    can start with a workflow command (`::warning::`, `::add-mask::`)."""
    clean = "".join(c if c.isprintable() or c == "\n" else "?" for c in str(text))
    return "\n".join(f"| {line}" for line in clean.splitlines())


def check(response, action):
    """Raise with the response body, which carries Zenodo's validation errors."""
    if not response.ok:
        print(f"Error while trying to {action}: HTTP {response.status_code}", file=sys.stderr)
        print(quote(response.text), file=sys.stderr)
    response.raise_for_status()
    return response


def as_id(value, what) -> int:
    """A Zenodo identifier as an integer, so that it can safely be placed in a URL."""
    if isinstance(value, bool):
        raise ZenodoError(f"{what} is not a valid identifier: {value!r}")
    if isinstance(value, int) and value > 0:
        return value
    if isinstance(value, str) and ID_RE.fullmatch(value):
        return int(value)
    raise ZenodoError(f"{what} is not a valid identifier: {value!r}")


def id_from_link(config: Config, link, collection, what) -> int:
    """The numeric id at the end of a Zenodo API link, which must point at the configured host.

    The links of an answer are never followed blindly: the authorization header would go with them.
    """
    if not isinstance(link, str):
        raise ZenodoError(f"{what} is missing or not a string: {link!r}")
    try:
        parts = urlsplit(link)
    except ValueError:
        raise ZenodoError(f"{what} is not a URL: {link!r}") from None
    prefix = f"/api/{collection}/"
    # `netloc` is compared whole, so that user information and ports are refused as well.
    if (
        parts.scheme != "https"
        or parts.netloc != urlsplit(config.base_url).netloc
        or parts.query
        or parts.fragment
        or not parts.path.startswith(prefix)
    ):
        raise ZenodoError(f"{what} does not point at {config.base_url}{prefix}…: {link!r}")
    return as_id(parts.path[len(prefix):], what)


def file_digest(path, algorithm) -> str:
    """Hex digest of a local file."""
    digest = hashlib.new(algorithm)
    with open(path, "rb") as fp:
        for chunk in iter(lambda: fp.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def parse_checksum(value):
    """(algorithm, hex digest) of a checksum reported by Zenodo, or None when it is not understood.

    Zenodo reports MD5 sums ("md5:<hex>" or a bare 32-hex string); a SHA-256 is recognised too.
    """
    if not isinstance(value, str):
        return None
    algorithm, sep, digest = value.partition(":")
    if not sep:
        algorithm, digest = {32: "md5", 64: "sha256"}.get(len(value), ""), value
    digest = digest.lower()
    sizes = {"md5": 32, "sha256": 64}
    if algorithm in sizes and re.fullmatch(f"[0-9a-f]{{{sizes[algorithm]}}}", digest):
        return algorithm, digest
    return None


def provenance_identifiers(config: Config) -> list[dict[str, str]]:
    """Related identifiers that tie the record to the tag, the commit and the release."""
    repo = f"https://github.com/{config.repository}"
    return [
        {
            "identifier": f"{repo}/tree/{config.tag}",
            "relation": "isSupplementTo",
            "scheme": "url",
        },
        {
            "identifier": f"{repo}/commit/{config.commit}",
            "relation": "isDerivedFrom",
            "scheme": "url",
        },
        {"identifier": config.release_url, "relation": "isIdenticalTo", "scheme": "url"},
    ]


def build_metadata(base_meta, file_meta, pdf_path, config: Config, pdf_sha256):
    """Shared metadata, overridden field by field by the per-file metadata, then the run-time facts.

    zenodo.json is never modified: the tag, the commit, the release and the SHA-256 of the PDF are
    only added to the copy sent to Zenodo.
    """
    if not isinstance(file_meta, dict):
        raise ConfigError("the per-file metadata of zenodo.files.json must be a JSON object.")
    meta = {**base_meta, **file_meta}
    creators = meta.get("creators")
    if (
        not isinstance(creators, list)
        or not creators
        or not all(isinstance(c, dict) and c.get("name") for c in creators)
    ):
        raise ConfigError(
            "zenodo.json must define `creators`: a non-empty list of objects that each have a `name`."
        )
    meta.setdefault("title", f"{base_meta.get('title', '')}: {os.path.basename(pdf_path)}")
    meta.setdefault("description", "")
    meta.setdefault("upload_type", "publication")
    meta.setdefault("publication_type", "report")
    meta.setdefault("license", "cc-by-4.0")
    meta["publication_date"] = str(date.today())
    meta["version"] = config.version

    related = [dict(item) for item in meta.get("related_identifiers", [])]
    for item in provenance_identifiers(config):
        if not any(
            known.get("identifier") == item["identifier"] and known.get("relation") == item["relation"]
            for known in related
        ):
            related.append(item)
    meta["related_identifiers"] = related

    facts = (
        f"SHA-256 du PDF ({os.path.basename(pdf_path)}) : {pdf_sha256}. "
        f"Source : dépôt {config.repository}, tag {config.tag}, commit {config.commit}."
    )
    notes = meta.get("notes", "")
    meta["notes"] = f"{notes}\n\n{facts}" if notes else facts
    return meta


def create_deposition(config: Config, metadata):
    r = requests.post(
        f"{config.api}/deposit/depositions",
        headers=config.headers,
        json={"metadata": metadata},
        timeout=TIMEOUT,
    )
    return check(r, "create a deposition").json()


def already_archived(record, config: Config) -> bool:
    """True when the record already carries the related identifier of this release's tag."""
    metadata = record.get("metadata")
    related = metadata.get("related_identifiers") if isinstance(metadata, dict) else None
    tag_url = f"https://github.com/{config.repository}/tree/{config.tag}"
    return isinstance(related, list) and any(
        isinstance(item, dict) and item.get("identifier") == tag_url for item in related
    )


def latest_record_id(config: Config) -> int:
    """Id of the latest published version of the declared concept, or an error.

    There is no fallback: when the declared concept cannot be read, creating a new record instead
    would produce a duplicate concept DOI, which cannot be undone.
    """
    r = requests.get(f"{config.api}/records/{config.concept}", headers=config.headers, timeout=TIMEOUT)
    record = check(r, f"read the concept record {config.concept}").json()
    concept = as_id(record.get("conceptrecid"), "conceptrecid of the declared record")
    if concept != config.concept:
        raise ZenodoError(
            f"record {config.concept} belongs to concept {concept}: ZENODO_CONCEPT_RECID must be the "
            "concept record id (the number of the concept DOI), not the id of a version."
        )
    if already_archived(record, config):
        raise ZenodoError(
            f"the latest version of concept {config.concept} already points at {config.tag}: "
            "this release is already archived, refusing to publish it a second time."
        )
    return as_id(record.get("id"), "id of the latest version")


def new_version_deposition(config: Config, recid: int, metadata):
    r = requests.post(
        f"{config.api}/deposit/depositions/{recid}/actions/newversion",
        headers=config.headers,
        timeout=TIMEOUT,
    )
    body = check(r, f"create a new version of record {recid}").json()
    draft_id = id_from_link(
        config, body.get("links", {}).get("latest_draft"), "deposit/depositions", "latest_draft link"
    )
    draft_url = f"{config.api}/deposit/depositions/{draft_id}"
    draft = check(requests.get(draft_url, headers=config.headers, timeout=TIMEOUT), "read the draft").json()

    r = requests.put(
        f"{config.api}/deposit/depositions/{as_id(draft.get('id'), 'id of the draft')}",
        headers=config.headers,
        json={"metadata": metadata},
        timeout=TIMEOUT,
    )
    return check(r, "update the draft metadata").json()


def verify_uploaded_checksum(config: Config, files_url, pdf_path, uploaded) -> str:
    """Compare the checksum Zenodo reports for the uploaded file with the local file.

    Raises on a mismatch. Returns a short description of what was established, "not verified" when
    the API does not report a checksum that can be compared.
    """
    name = os.path.basename(pdf_path)
    checksum = uploaded.get("checksum") if isinstance(uploaded, dict) else None
    if not checksum:
        listing = check(
            requests.get(files_url, headers=config.headers, timeout=TIMEOUT), "list files"
        ).json()
        for entry in listing if isinstance(listing, list) else []:
            if isinstance(entry, dict) and name in (entry.get("filename"), entry.get("key")):
                checksum = entry.get("checksum")
    parsed = parse_checksum(checksum)
    if parsed is None:
        print(f"   Warning: Zenodo reported no usable checksum for {name}: upload not verified.")
        return "not verified (no usable checksum reported by Zenodo)"
    algorithm, remote = parsed
    local = file_digest(pdf_path, algorithm)
    if local != remote:
        raise ZenodoError(
            f"{algorithm} of the uploaded {name} differs from the local file "
            f"(Zenodo {remote}, local {local}): nothing was published."
        )
    print(f"   Zenodo {algorithm} checksum matches the local file.")
    return f"{algorithm} reported by Zenodo matches the local file"


def replace_files(config: Config, deposit_id: int, pdf_path) -> str:
    """Make `pdf_path` the only file of the deposition (a new version inherits the old files)."""
    files_url = f"{config.api}/deposit/depositions/{deposit_id}/files"
    existing = check(
        requests.get(files_url, headers=config.headers, timeout=TIMEOUT), "list files"
    ).json()
    for f in existing:
        file_id = f.get("id")
        if not isinstance(file_id, str) or not FILE_ID_RE.fullmatch(file_id):
            raise ZenodoError(f"file id is not valid: {file_id!r}")
        r = requests.delete(f"{files_url}/{file_id}", headers=config.headers, timeout=TIMEOUT)
        check(r, f"delete {f.get('filename')}")

    with open(pdf_path, "rb") as fp:
        r = requests.post(
            files_url,
            headers=config.headers,
            data={"name": os.path.basename(pdf_path)},
            files={"file": fp},
            timeout=TIMEOUT,
        )
    uploaded = check(r, f"upload {pdf_path}").json()
    return verify_uploaded_checksum(config, files_url, pdf_path, uploaded)


@dataclass
class Outcome:
    """How far a run got. After `published` is set the DOI exists and nothing can undo it."""

    pdf_sha256: str | None = None
    checksum_status: str | None = None
    deposit_id: int | None = None
    publishing: bool = False  # the publish request has been sent: from here the state may be final
    published: dict | None = None  # Zenodo's answer to it: the DOI exists
    record: dict | None = None  # the published record, read back


def publish_deposition(config: Config, deposit_id: int) -> dict:
    """The irreversible step. Returns Zenodo's answer, which carries the DOI."""
    r = requests.post(
        f"{config.api}/deposit/depositions/{deposit_id}/actions/publish",
        headers=config.headers,
        timeout=TIMEOUT,
    )
    published = check(r, "publish the deposition").json()
    if not isinstance(published, dict):
        raise ZenodoError(f"Zenodo answered the publish request with {published!r}")
    # From here on the DOI exists and cannot be withdrawn: say so before anything else can fail.
    print(
        f"   Published deposition {deposit_id}: DOI {published.get('doi')}, "
        f"concept record {published.get('conceptrecid')}"
    )
    return published


def read_published_record(config: Config, published: dict) -> dict:
    """The published record, read back. May raise anything: the caller has the publish answer."""
    link = (published.get("links") or {}).get("record")
    record_id = (
        id_from_link(config, link, "records", "record link")
        if link
        else as_id(published.get("id"), "id of the published record")
    )
    # The published record carries the concept DOI and the concept record id.
    r = requests.get(f"{config.api}/records/{record_id}", headers=config.headers, timeout=TIMEOUT)
    record = check(r, "read the published record").json()
    if not isinstance(record, dict):
        raise ZenodoError(
            f"Zenodo answered the read of the published record with a {type(record).__name__}, not an object"
        )
    return record


def summary(lines, environ):
    path = environ.get("GITHUB_STEP_SUMMARY")
    if path:
        with open(path, "a", encoding="utf-8") as f:
            f.write("\n".join(lines) + "\n")


def publish_pdf(config: Config, pdf_path, base_meta, files_meta, outcome: Outcome):
    """Publish one PDF, recording in `outcome` how far it got."""
    key = os.path.normpath(pdf_path)
    pdf_sha256 = file_digest(pdf_path, "sha256")
    outcome.pdf_sha256 = pdf_sha256
    metadata = build_metadata(base_meta, files_meta.get(key, {}), key, config, pdf_sha256)

    print(f"==> Sync {key} (SHA-256 {pdf_sha256})")
    if config.concept is None:
        print("   ZENODO_CONCEPT_RECID=NEW: creating a new record and a new concept DOI")
        deposition = create_deposition(config, metadata)
    else:
        recid = latest_record_id(config)
        print(f"   Concept {config.concept}: latest version is record {recid}; new version")
        deposition = new_version_deposition(config, recid, metadata)

    deposit_id = as_id(deposition.get("id"), "id of the deposition")
    outcome.deposit_id = deposit_id
    outcome.checksum_status = replace_files(config, deposit_id, pdf_path)
    outcome.publishing = True
    outcome.published = publish_deposition(config, deposit_id)
    outcome.record = read_published_record(config, outcome.published)


def redact(text: str, config: Config) -> str:
    """`text` with the token removed and every non-printable character replaced."""
    if config.token:
        text = text.replace(config.token, "***")
    return "".join(c if c.isprintable() else "?" for c in text)


def report_lines(config: Config, pdf_path, outcome: Outcome, problem=None) -> list[str]:
    """The job summary: the identifiers, and what to do next. Written even when a step failed."""
    published = outcome.published or {}
    record = outcome.record or {}

    def fact(key):
        return record.get(key) or published.get(key)

    doi, concept_doi, concept_recid = fact("doi"), fact("conceptdoi"), fact("conceptrecid")
    if outcome.published is None:
        lines = [
            f"## Zenodo ({config.env}) : publication INCERTAINE",
            "",
            f"La requête de publication du dépôt {outcome.deposit_id} a été envoyée mais sa réponse n'a "
            "pas été reçue : le DOI a peut-être été créé. **Vérifier sur Zenodo avant de rejouer quoi "
            "que ce soit** ; un DOI publié ne peut pas être retiré.",
        ]
    else:
        lines = [
            f"## Zenodo ({config.env})",
            "",
            "| Fichier | DOI de la version | DOI du concept |",
            "|---|---|---|",
            f"| `{os.path.normpath(pdf_path)}` | [{doi}](https://doi.org/{doi}) | {concept_doi} |",
            "",
            f"- Tag : `{config.tag}`, commit : `{config.commit}`",
            f"- SHA-256 du PDF : `{outcome.pdf_sha256}`",
            f"- Somme de contrôle côté Zenodo : {outcome.checksum_status}",
            f"- Identifiant d'enregistrement du concept : `{concept_recid}`",
        ]
    if problem is not None:
        lines += [
            "",
            f"**Anomalie après la publication** : `{problem}`. Le dépôt est publié (ou peut l'être) : "
            "**ne pas rejouer ce job** (un « Re-run » ne corrigerait rien et pourrait créer un second "
            "enregistrement). Renseigner la variable `ZENODO_CONCEPT_RECID` avec "
            f"`{concept_recid}`, puis vérifier l'enregistrement sur Zenodo.",
        ]
    elif config.concept is None:
        lines += [
            "",
            f"**Action requise** : un nouveau concept a été créé. Définir la variable "
            f"`ZENODO_CONCEPT_RECID` = `{concept_recid}` avant la prochaine release, faute de quoi "
            "elle publierait de nouveau un enregistrement distinct. Ne pas rejouer ce job.",
        ]
    return lines


def write_report(config: Config, pdf_path, outcome: Outcome, environ, problem=None) -> None:
    """Print the identifiers, then write the summary. Reporting must never turn a published record
    into a crash: whatever goes wrong here is a warning, with the token removed."""
    try:
        published = outcome.published or {}
        record = outcome.record or {}
        print(f"   Published DOI: {record.get('doi') or published.get('doi')}")
        print(f"   Concept DOI: {record.get('conceptdoi') or published.get('conceptdoi')}")
        print(f"   Concept record id: {record.get('conceptrecid') or published.get('conceptrecid')}")
        summary(report_lines(config, pdf_path, outcome, problem), environ)
    except Exception as error:  # noqa: BLE001 - see the docstring
        print(
            f"   Warning: the report could not be written: {redact(f'{type(error).__name__}: {error}', config)}",
            file=sys.stderr,
        )


def run(argv=None, environ=None) -> int:
    environ = os.environ if environ is None else environ
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument(
        "--check-config",
        action="store_true",
        help="validate the environment (no token needed, no network) and exit",
    )
    args = parser.parse_args(argv)

    try:
        config = load_config(environ, require_token=not args.check_config)
    except ConfigError as error:
        print(f"Configuration error: {error}", file=sys.stderr)
        return 2
    if args.check_config:
        target = "a new record" if config.concept is None else f"concept {config.concept}"
        print(f"Configuration OK: {config.env}, {config.tag} -> {target}.")
        return 0

    pdfs = sorted(glob.glob(os.path.join(config.files_dir, "*.pdf")))
    if not pdfs:
        print(f"No PDF found in {config.files_dir}/: nothing to publish.", file=sys.stderr)
        return 1
    if len(pdfs) > 1:
        print(
            f"{len(pdfs)} PDFs found in {config.files_dir}/ ({', '.join(pdfs)}): one concept record "
            "holds one document, refusing to publish them under the same concept.",
            file=sys.stderr,
        )
        return 1

    outcome = Outcome()
    try:
        base_meta = load_json_object("zenodo.json", required=True)
        files_meta = load_json_object("zenodo.files.json", required=False)
        publish_pdf(config, pdfs[0], base_meta, files_meta, outcome)
    except ConfigError as error:  # raised before any network call
        print(f"Configuration error: {error}", file=sys.stderr)
        return 2
    except BaseException as error:  # noqa: BLE001 - what to do depends on how far the run got
        if not outcome.publishing:
            if isinstance(error, ZenodoError):
                print(f"Refused: {redact(str(error), config)}", file=sys.stderr)
                return 1
            raise  # nothing was published: the traceback is the report
        status = getattr(getattr(error, "response", None), "status_code", 0)
        refused = isinstance(error, requests.HTTPError) and status in CLEAR_REFUSALS
        if outcome.published is None and refused:
            raise  # Zenodo answered the publish request with a clear refusal: nothing was published
        # The DOI exists, or may exist: never lose its identifiers, never invite a re-run.
        problem = redact(f"{type(error).__name__}: {error}", config)
        print(f"Error after the publish request: {problem}", file=sys.stderr)
        write_report(config, pdfs[0], outcome, environ, problem)
        if not isinstance(error, Exception):
            raise  # an interrupt or an exit request is not swallowed, but the identifiers come first
        return 3

    write_report(config, pdfs[0], outcome, environ)
    return 0


if __name__ == "__main__":
    sys.exit(run())
