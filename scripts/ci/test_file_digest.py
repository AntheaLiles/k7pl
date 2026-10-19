# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Tests for the shared file digest of the SPDX validation tooling."""

from __future__ import annotations

import hashlib
import tempfile
import unittest
from pathlib import Path

import benchmark_spdx_validator
import evaluate_spdx_negative_corpus
import file_digest
import validate_spdx
from file_digest import CHUNK_SIZE, sha256_file


class Sha256FileTests(unittest.TestCase):
    def digest_of(self, data: bytes) -> str:
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "input.bin"
            path.write_bytes(data)
            return sha256_file(path)

    def test_known_vectors(self):
        self.assertEqual(
            self.digest_of(b""), "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
        )
        self.assertEqual(
            self.digest_of(b"abc"), "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
        )

    def test_chunk_boundaries_do_not_change_the_digest(self):
        for size in (CHUNK_SIZE - 1, CHUNK_SIZE, CHUNK_SIZE + 1, 3 * CHUNK_SIZE + 7):
            with self.subTest(size=size):
                data = bytes(index % 251 for index in range(size))
                self.assertEqual(self.digest_of(data), hashlib.sha256(data).hexdigest())

    def test_a_missing_file_is_an_error_not_a_digest(self):
        with tempfile.TemporaryDirectory() as tmp, self.assertRaises(FileNotFoundError):
            sha256_file(Path(tmp) / "absent")


class SharedImplementationTests(unittest.TestCase):
    """The wrapper, the harness and the benchmark compute their evidence digests the same way."""

    def test_the_three_tools_use_the_shared_function(self):
        for module in (validate_spdx, evaluate_spdx_negative_corpus, benchmark_spdx_validator):
            with self.subTest(module=module.__name__):
                self.assertIs(module.sha256_file, file_digest.sha256_file)

    def test_the_harness_evidence_binds_the_helper(self):
        hashes = evaluate_spdx_negative_corpus._tool_input_hashes()
        self.assertEqual(hashes["digestHelperSha256"], sha256_file(Path(file_digest.__file__)))


if __name__ == "__main__":
    unittest.main()
