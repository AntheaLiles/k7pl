#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
source_dir="$repo_root/spec/figures/tikz"
manifest="$source_dir/manifest.json"
out_dir="$repo_root/out/tikz-production"
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
  local pass="$1" id="$2" source="$3" stem="$4" destination="$5"
  local build_dir="$work_dir/$pass/$id"
  mkdir -p "$build_dir"
  cp "$source_dir/$source" "$build_dir/main.tex"
  (
    cd "$build_dir"
    tectonic -X compile --keep-logs -Z deterministic-mode main.tex
    pdftocairo -svg main.pdf "$destination/$stem.svg"
  )
  if [[ -f "$destination/$stem-1.svg" ]]; then
    mv "$destination/$stem-1.svg" "$destination/$stem.svg"
  elif [[ ! -f "$destination/$stem.svg" ]]; then
    echo "::error::pdftocairo did not produce an SVG for $stem" >&2
    exit 1
  fi
  cp "$build_dir/main.pdf" "$destination/$stem.pdf"
}

while IFS=$'\t' read -r id source stem; do
  [[ -n "$id" && -n "$source" && -n "$stem" ]] || continue
  echo "::group::TikZ figure: $id (first build)"
  build_one first "$id" "$source" "$stem" "$first_dir"
  echo "::endgroup::"
  echo "::group::TikZ figure: $id (second build)"
  build_one second "$id" "$source" "$stem" "$second_dir"
  echo "::endgroup::"

  for extension in pdf svg; do
    if ! cmp --silent "$first_dir/$stem.$extension" "$second_dir/$stem.$extension"; then
      echo "::error::Non-deterministic $extension output for $id" >&2
      exit 1
    fi
  done
  echo "reproducible: $id -> $stem (PDF + SVG)"
done < <(python3 - "$manifest" <<'PY'
import json, sys
with open(sys.argv[1], encoding="utf-8") as stream:
    manifest = json.load(stream)
if manifest.get("status") != "canonical-tikz-sources":
    raise SystemExit("TikZ source manifest has an unexpected status")
for figure in manifest["figures"]:
    print(f'{figure["id"]}\t{figure["source"]}\t{figure["asset_stem"]}')
PY
)

cp "$first_dir"/*.pdf "$out_dir/"
cp "$first_dir"/*.svg "$out_dir/"
rm -rf "$first_dir" "$second_dir" "$work_dir"
python3 "$repo_root/scripts/ci/check_tikz_figures.py" --generated "$out_dir"
sha256sum "$out_dir"/*.pdf "$out_dir"/*.svg
