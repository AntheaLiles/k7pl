#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Publish the PDFs built by the CI to Zenodo, one record (and one concept DOI) per file.

Adapted from the quickViz synchronisation script. Each PDF found in ZENODO_FILES_DIR is
published as a new version of its own Zenodo record; the first publication creates the record.

Inputs:
  zenodo.json           metadata shared by every record
  zenodo.files.json     per-file metadata, keyed by "<ZENODO_FILES_DIR>/<name>.pdf"
  .zenodo_state.json    concept record of each file (kept on the `zenodo-state` branch)

Environment:
  ZENODO_TOKEN          personal access token (scopes: deposit:write, deposit:actions)
  ZENODO_ENV            "production" (default) or "sandbox"
  ZENODO_VERSION        version of the release (e.g. "0.1.0"), stored in the metadata
  ZENODO_FILES_DIR      directory of the PDFs to publish (default: "out")
  GITHUB_STEP_SUMMARY   optional, receives a Markdown summary of the published DOIs
"""

import glob
import json
import os
import sys
from datetime import date

import requests

ZENODO_ENV = os.getenv("ZENODO_ENV") or "production"
ZENODO_TOKEN = os.getenv("ZENODO_TOKEN")
ZENODO_VERSION = os.getenv("ZENODO_VERSION")
FILES_DIR = os.getenv("ZENODO_FILES_DIR") or "out"

BASE_URL = "https://sandbox.zenodo.org" if ZENODO_ENV == "sandbox" else "https://zenodo.org"
API = f"{BASE_URL}/api"
HEADERS = {"Authorization": f"Bearer {ZENODO_TOKEN}"}
TIMEOUT = 120

STATE_FILE = ".zenodo_state.json"


def load_json(path, default=None):
    """Load a JSON file; return `default` (or {}) when it is missing, empty or invalid."""
    fallback = default if default is not None else {}
    if not os.path.exists(path) or os.stat(path).st_size == 0:
        return fallback
    try:
        with open(path, encoding="utf-8") as f:
            return json.load(f)
    except json.JSONDecodeError:
        return fallback


def save_json(path, data):
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
        f.write("\n")


def check(response, action):
    """Raise with the response body, which carries Zenodo's validation errors."""
    if not response.ok:
        print(f"Error while trying to {action}: HTTP {response.status_code}", file=sys.stderr)
        print(response.text, file=sys.stderr)
    response.raise_for_status()
    return response


def build_metadata(base_meta, file_meta, pdf_path):
    """Shared metadata, overridden field by field by the per-file metadata."""
    meta = {**base_meta, **file_meta}
    meta.setdefault("title", f"{base_meta.get('title', '')}: {os.path.basename(pdf_path)}")
    meta.setdefault("description", "")
    meta.setdefault("upload_type", "publication")
    meta.setdefault("publication_type", "report")
    meta.setdefault("license", "cc-by-4.0")
    meta["publication_date"] = str(date.today())
    if ZENODO_VERSION:
        meta["version"] = ZENODO_VERSION
    return meta


def create_deposition(metadata):
    r = requests.post(
        f"{API}/deposit/depositions",
        headers=HEADERS,
        json={"metadata": metadata},
        timeout=TIMEOUT,
    )
    return check(r, "create a deposition").json()


def latest_record_id(file_state):
    """Id of the latest published version of the record described by `file_state`."""
    conceptrecid = file_state.get("conceptrecid")
    if conceptrecid:
        # Zenodo resolves a concept record id to its latest version.
        r = requests.get(f"{API}/records/{conceptrecid}", headers=HEADERS, timeout=TIMEOUT)
        if r.ok:
            return r.json()["id"]
    return file_state.get("recid")


def new_version_deposition(file_state, metadata):
    recid = latest_record_id(file_state)
    if recid is None:
        print("   Previous record not found: creating a new record")
        return create_deposition(metadata)

    r = requests.post(
        f"{API}/deposit/depositions/{recid}/actions/newversion",
        headers=HEADERS,
        timeout=TIMEOUT,
    )
    draft_url = check(r, f"create a new version of record {recid}").json()["links"]["latest_draft"]
    draft = check(requests.get(draft_url, headers=HEADERS, timeout=TIMEOUT), "read the draft").json()

    r = requests.put(
        f"{API}/deposit/depositions/{draft['id']}",
        headers=HEADERS,
        json={"metadata": metadata},
        timeout=TIMEOUT,
    )
    return check(r, "update the draft metadata").json()


def replace_files(deposition, pdf_path):
    """Make `pdf_path` the only file of the deposition (a new version inherits the old files)."""
    files_url = f"{API}/deposit/depositions/{deposition['id']}/files"
    existing = check(requests.get(files_url, headers=HEADERS, timeout=TIMEOUT), "list files").json()
    for f in existing:
        r = requests.delete(f"{files_url}/{f['id']}", headers=HEADERS, timeout=TIMEOUT)
        check(r, f"delete {f['filename']}")

    with open(pdf_path, "rb") as fp:
        r = requests.post(
            files_url,
            headers=HEADERS,
            data={"name": os.path.basename(pdf_path)},
            files={"file": fp},
            timeout=TIMEOUT,
        )
    check(r, f"upload {pdf_path}")


def publish(deposition):
    r = requests.post(
        f"{API}/deposit/depositions/{deposition['id']}/actions/publish",
        headers=HEADERS,
        timeout=TIMEOUT,
    )
    published = check(r, "publish the deposition").json()
    # The published record carries the concept DOI and the concept record id.
    r = requests.get(published["links"]["record"], headers=HEADERS, timeout=TIMEOUT)
    return check(r, "read the published record").json()


def summary(lines):
    path = os.getenv("GITHUB_STEP_SUMMARY")
    if path:
        with open(path, "a", encoding="utf-8") as f:
            f.write("\n".join(lines) + "\n")


def main():
    if not ZENODO_TOKEN:
        raise SystemExit("ZENODO_TOKEN is not set.")

    pdfs = sorted(glob.glob(os.path.join(FILES_DIR, "*.pdf")))
    if not pdfs:
        raise SystemExit(f"No PDF found in {FILES_DIR}/: nothing to publish.")

    base_meta = load_json("zenodo.json")
    files_meta = load_json("zenodo.files.json")
    state = load_json(STATE_FILE)

    report = [f"## Zenodo ({ZENODO_ENV})", "", "| Fichier | DOI de la version | DOI du concept |",
              "|---|---|---|"]
    for pdf_path in pdfs:
        key = os.path.normpath(pdf_path)
        file_state = state.get(key, {})
        metadata = build_metadata(base_meta, files_meta.get(key, {}), key)

        print(f"==> Sync {key}")
        if file_state:
            print(f"   Existing record (concept DOI {file_state.get('conceptdoi')}): new version")
            deposition = new_version_deposition(file_state, metadata)
        else:
            print("   First publication: new record")
            deposition = create_deposition(metadata)

        replace_files(deposition, pdf_path)
        record = publish(deposition)

        doi = record.get("doi")
        print(f"   Published DOI: {doi}")
        print(f"   Concept DOI: {record.get('conceptdoi')}")
        state[key] = {
            "conceptdoi": record.get("conceptdoi"),
            "conceptrecid": record.get("conceptrecid"),
            "recid": record.get("id"),
            "doi": doi,
        }
        report.append(f"| `{key}` | [{doi}](https://doi.org/{doi}) | {record.get('conceptdoi')} |")

    save_json(STATE_FILE, state)
    summary(report)


if __name__ == "__main__":
    main()
