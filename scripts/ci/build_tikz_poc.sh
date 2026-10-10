#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
poc_dir="$repo_root/docs/tracking/tikz-poc"
out_dir="${TIKZ_POC_OUT:-$repo_root/out/tikz-poc}"
work_dir="$out_dir/.work"
first_dir="$out_dir/.first"
second_dir="$out_dir/.second"

: "${SOURCE_DATE_EPOCH:=946684800}"
export SOURCE_DATE_EPOCH

command -v tectonic >/dev/null || { echo "tectonic is required" >&2; exit 2; }
command -v pdftocairo >/dev/null || { echo "pdftocairo (Poppler) is required" >&2; exit 2; }

rm -rf "$out_dir"
mkdir -p "$first_dir" "$second_dir" "$work_dir"

build_one() {
  local pass="$1" id="$2" source="$3" destination="$4"
  local build_dir="$work_dir/$pass/$id"
  mkdir -p "$build_dir"
  cp "$poc_dir/$source" "$build_dir/main.tex"
  (
    cd "$build_dir"
    tectonic -X compile --keep-logs -Z deterministic-mode main.tex
    pdftocairo -svg main.pdf "$destination/$id.svg"
  )
  if [[ -f "$destination/$id-1.svg" ]]; then
    mv "$destination/$id-1.svg" "$destination/$id.svg"
  elif [[ ! -f "$destination/$id.svg" ]]; then
    echo "::error::pdftocairo did not produce an SVG for $id" >&2
    exit 1
  fi
  cp "$build_dir/main.pdf" "$destination/$id.pdf"
}

while IFS=$'\t' read -r id source; do
  [[ -n "$id" && -n "$source" ]] || continue
  echo "::group::TikZ POC: $id (first build)"
  build_one first "$id" "$source" "$first_dir"
  echo "::endgroup::"
  echo "::group::TikZ POC: $id (second build)"
  build_one second "$id" "$source" "$second_dir"
  echo "::endgroup::"
  for extension in pdf svg; do
    if ! cmp --silent "$first_dir/$id.$extension" "$second_dir/$id.$extension"; then
      echo "::error::Non-deterministic $extension output for $id" >&2
      exit 1
    fi
  done
  echo "reproducible: $id (PDF + SVG)"
done < <(python3 - "$poc_dir/manifest.json" <<'PY'
import json, sys
with open(sys.argv[1], encoding="utf-8") as stream:
    manifest = json.load(stream)
for figure in manifest["figures"]:
    print(f'{figure["id"]}\t{figure["source"]}')
PY
)

cp "$first_dir"/*.pdf "$out_dir/"
cp "$first_dir"/*.svg "$out_dir/"
rm -rf "$first_dir" "$second_dir" "$work_dir"
python3 "$repo_root/scripts/ci/check_tikz_poc.py" --root "$out_dir"
sha256sum "$out_dir"/*.pdf "$out_dir"/*.svg
