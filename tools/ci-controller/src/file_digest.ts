// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * SHA-256 digest of a file, shared by the SPDX validation tooling.
 *
 * Port of scripts/ci/file_digest.py. The Python implementation reads
 * the file in 1 MiB chunks; this port reads the whole file and hashes
 * it with WebCrypto, which yields the identical digest (SHA-256 is
 * independent of chunking). Evidence files hashed here are small;
 * if a multi-gigabyte input ever needs hashing, reintroduce chunked
 * hashing rather than buffering it.
 */

function toHex(bytes: Uint8Array): string {
  return [...bytes].map((b) => b.toString(16).padStart(2, "0")).join("");
}

export async function sha256File(path: string): Promise<string> {
  const data = await Deno.readFile(path);
  const digest = await crypto.subtle.digest("SHA-256", data);
  return toHex(new Uint8Array(digest));
}
