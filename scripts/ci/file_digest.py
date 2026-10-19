# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""SHA-256 digest of a file, shared by the SPDX validation tooling.

The SPDX wrapper (`validate_spdx.py`), its negative-corpus harness and its benchmark record these
digests in their evidence, so the three must compute them identically. The evidence of the
harness and of the benchmark hashes this module too, since its code determines the digests.
"""

from __future__ import annotations

import hashlib
from pathlib import Path

CHUNK_SIZE = 1024 * 1024


def sha256_file(path: Path) -> str:
    """Hexadecimal SHA-256 of the bytes of `path`, read in chunks of one mebibyte."""
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(CHUNK_SIZE), b""):
            digest.update(chunk)
    return digest.hexdigest()
