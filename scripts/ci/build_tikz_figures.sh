#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
# SPDX-License-Identifier: CC0-1.0
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
source_dir="$repo_root/spec/figures/tikz"
manifest="$source_dir/manifest.json"
out_dir="${TIKZ_FIGURES_OUT:-$repo_root/out/tikz-production}"
work_dir="$out_dir/.work"

: "${SOURCE_DATE_EPOCH:=946684800}"
export SOURCE_DATE_EPOCH

command -v tectonic >/dev/null || { echo "tectonic is required" >&2; exit 2; }
command -v pdftocairo >/dev/null || { echo "pdftocairo (Poppler) is required" >&2; exit 2; }

rm -rf "$out_dir"
mkdir -p "$out_dir" "$work_dir"

while IFS=$'\t' read -r id source stem; do
  [[ -n "$id" && -n "$source" && -n "$stem" ]] || continue
  build_dir="$work_dir/$id"
  mkdir -p "$build_dir"
  cp "$source_dir/$source" "$build_dir/main.tex"
  echo "::group::Build TikZ figure: $id"
  (
    cd "$build_dir"
    tectonic -X compile --keep-logs -Z deterministic-mode main.tex
    pdftocairo -svg main.pdf "$out_dir/$stem.svg"
  )
  cp "$build_dir/main.pdf" "$out_dir/$stem.pdf"
  echo "::endgroup::"
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

rm -rf "$work_dir"
python3 "$repo_root/scripts/ci/check_tikz_figures.py" --generated "$out_dir"
sha256sum "$out_dir"/*.pdf "$out_dir"/*.svg
