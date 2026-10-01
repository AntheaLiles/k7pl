# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Bibliography pipeline of the specification.

    biblio.py slim <source.bib> <keys.txt> <references.json>   # extracts the cited entries
    biblio.py lean <references.json> <SpecBib.lean>            # generates the Lean module

The full Zotero library (abstracts, local file paths, uncited entries) stays out of the
repository; only the bibliographic metadata of the works the specification cites is kept. The
formatting follows ISO 690 (numeric), roughly as the manuscript obtained it from `biblatex`
(`bibstyle=iso-numeric`).
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path


#: fields kept; everything else (abstracts, files, keywords…) is dropped
KEEP = [
    "author", "editor", "translator", "title", "subtitle", "booktitle", "journaltitle", "journal",
    "date", "year", "volume", "number", "pages", "series", "edition", "publisher", "organization",
    "institution", "school", "location", "address", "doi", "url", "urldate", "eprint", "eprinttype",
    "isbn", "howpublished", "version", "type", "note", "langid", "chapter", "eventtitle", "issn",
]


def clean(s: str) -> str:
    """Strips the BibTeX/LaTeX markup of a field and returns plain text."""
    s = s.replace("\\&", "&").replace("\\_", "_").replace("\\%", "%").replace("\\$", "$").replace("\\#", "#")
    s = s.replace("--", "–")
    s = re.sub(r"\\(?:textit|emph|textbf|textsc|texttt|url|mkbibquote)\{([^{}]*)\}", r"\1", s)
    s = re.sub(r"\\[`'^\"~=.]\{?\\?([A-Za-z])\}?", lambda m: m.group(1), s)
    s = s.replace("{", "").replace("}", "")
    s = re.sub(r"\s+", " ", s).strip()
    return s


def read_bib(src: str, wanted: set[str]) -> dict[str, dict]:
    """Reads only the `wanted` entries of a BibLaTeX file (minimal parser, tolerant of the
    extended name syntax `family=…, given=…`)."""
    text = Path(src).read_text(encoding="utf-8")
    out: dict[str, dict] = {}
    for m in re.finditer(r"^@(\w+)\s*\{\s*([^,\s]+)\s*,", text, re.M):
        key = m.group(2)
        if key not in wanted:
            continue
        i = m.end()
        depth = 1
        j = i
        while j < len(text) and depth:
            c = text[j]
            if c == "\\":
                j += 2
                continue
            if c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
            j += 1
        body = text[i : j - 1]
        fields: dict[str, str] = {}
        k = 0
        while True:
            fm = re.compile(r"\s*([A-Za-z][\w-]*)\s*=\s*").search(body, k)
            if not fm:
                break
            k = fm.end()
            if k >= len(body):
                break
            if body[k] == "{":
                d = 1
                e = k + 1
                while e < len(body) and d:
                    if body[e] == "\\":
                        e += 2
                        continue
                    if body[e] == "{":
                        d += 1
                    elif body[e] == "}":
                        d -= 1
                    e += 1
                val = body[k + 1 : e - 1]
                k = e
            elif body[k] == '"':
                e = body.index('"', k + 1)
                val = body[k + 1 : e]
                k = e + 1
            else:
                e = re.compile(r"[,\s]").search(body, k)
                e = e.start() if e else len(body)
                val = body[k:e]
                k = e
            fields[fm.group(1).lower()] = val
        out[key] = {"type": m.group(1).lower(), "fields": fields}
    return out


def split_names(s: str) -> list[dict]:
    """`A and B` (BibTeX) or `family=…, given=…` (extended BibLaTeX) → list of persons."""
    persons = []
    for chunk in re.split(r"\s+and\s+", s):
        chunk = chunk.strip()
        if not chunk:
            continue
        if "family=" in chunk:
            kv = dict(
                (a.strip(), b.strip().strip("{}")) for a, _, b in (p.partition("=") for p in re.split(r",\s*(?=\w+=)", chunk))
            )
            last = (kv.get("prefix", "") + " " + kv.get("family", "")).strip() if kv.get("useprefix") == "true" else kv.get("family", "")
            persons.append({"last": last, "first": kv.get("given", ""), "lineage": kv.get("suffix", "")})
        elif chunk.startswith("{") and chunk.endswith("}"):
            persons.append({"last": chunk[1:-1], "first": "", "lineage": ""})
        elif "," in chunk:
            parts = [p.strip() for p in chunk.split(",")]
            if len(parts) == 3:
                persons.append({"last": parts[0], "first": parts[2], "lineage": parts[1]})
            else:
                persons.append({"last": parts[0], "first": ", ".join(parts[1:]), "lineage": ""})
        else:
            w = chunk.split()
            persons.append({"last": w[-1], "first": " ".join(w[:-1]), "lineage": ""})
    return persons


def slim(src: str, keys_file: str, out: str) -> None:
    keys = [k for k in Path(keys_file).read_text(encoding="utf-8").split() if k]
    db = read_bib(src, set(keys))
    entries = {}
    missing = []
    for k in keys:
        if k not in db:
            missing.append(k)
            continue
        e = db[k]
        rec: dict = {"type": e["type"]}
        for f in KEEP:
            if f in e["fields"] and f not in ("author", "editor", "translator"):
                rec[f] = e["fields"][f]
        persons = {}
        for role in ("author", "editor", "translator"):
            if role in e["fields"]:
                persons[role] = split_names(e["fields"][role])
        rec["persons"] = persons
        entries[k] = rec
    Path(out).write_text(json.dumps({"entries": entries}, ensure_ascii=False, indent=1, sort_keys=True) + "\n", encoding="utf-8")
    print(f"{len(entries)} notices extraites, {len(missing)} clés absentes de la source")
    for k in missing:
        print("  absente :", k)


# --------------------------------------------------------------------------------------
# Formatting (ISO 690 numeric, approximate)
# --------------------------------------------------------------------------------------


def names(ps: list[dict]) -> str:
    out = []
    for p in ps:
        last = clean(p["last"]).upper()
        if p.get("lineage"):
            last += " " + clean(p["lineage"])
        first = clean(p["first"])
        out.append(f"{last}, {first}" if first else last)
    return "; ".join(out)


def stop(s: str) -> str:
    """`s` ended by exactly one full stop."""
    s = s.rstrip()
    return s if s.endswith((".", "?", "!")) else s + "."


def fmt(rec: dict) -> tuple[list[tuple[bool, str]], str | None, str | None]:
    """Returns (fragments (italic, text), doi, url) in the ISO 690 numeric style."""
    g = lambda k: clean(rec[k]) if k in rec and rec[k] else ""
    persons = rec.get("persons", {})
    typ = rec["type"].lower()
    parts: list[tuple[bool, str]] = []

    def add(text: str, it: bool = False) -> None:
        if text:
            parts.append((it, text))

    authors = names(persons["author"]) if "author" in persons else ""
    editors = names(persons["editor"]) if "editor" in persons else ""
    lead = authors or (editors + " (éd.)" if editors else "")
    if lead:
        add(stop(lead) + " ")
    doi = g("doi") or None
    url = g("url") or None
    if doi:
        url = None
    elif url and url.startswith("https://doi.org/"):
        doi, url = url[len("https://doi.org/") :], None
    online = bool(doi or url)
    title = g("title")
    sub = g("subtitle")
    if sub:
        title = title + (" " if title.endswith(("?", "!", ":")) else " : ") + sub
    container = g("journaltitle") or g("journal") or g("booktitle")
    in_book = typ in ("incollection", "inproceedings", "inbook", "conference")
    if container:
        add(stop(title) + " ")
        if in_book:
            add("In: ")
            if editors and authors:
                add(f"{editors} (éd.). ")
        add(container, True)
        add(" [en ligne]" if online else "")
        add(". ")
    else:
        add(title, True)
        add(" [en ligne]" if online else "")
        add(". ")
    ed = g("edition")
    if ed:
        add(f"{ed}{'e' if ed.isdigit() else ''} éd. ")
    if rec.get("version"):
        add(f"Version {g('version')}. ")
    loc = g("location") or g("address")
    pub = g("publisher") or g("organization") or g("institution") or g("school")
    if typ in ("phdthesis", "mastersthesis", "thesis") and pub:
        add(f"Thèse. {pub}. ")
    elif loc or pub:
        add((loc + ": " if loc and pub else loc) + (pub if pub else "") + ", ")
    date = g("date") or g("year")
    add(date[:4] if date else "s. d.")
    vol = g("volume")
    num = g("number")
    if vol:
        add(f", vol. {vol}")
    if num:
        add(f", no. {num}")
    pg = g("pages")
    if pg:
        add(f", p. {pg.replace(' ', '')}")
    ud = g("urldate")
    if ud and online:
        add(f" [visité le {ud}]")
    add(".")
    return parts, doi, url


def lean_str(s: str) -> str:
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"') + '"'


def gen_lean(refs: str, out: str) -> None:
    data = json.loads(Path(refs).read_text(encoding="utf-8"))["entries"]
    lines = []
    for k in sorted(data):
        parts, doi, url = fmt(data[k])
        ps = ", ".join(f"({'true' if it else 'false'}, {lean_str(t)})" for it, t in parts)
        d = f"some {lean_str(doi)}" if doi else "none"
        u = f"some {lean_str(url)}" if url else "none"
        lines.append(f"  ({lean_str(k)}, [{ps}], {d}, {u})")
    body = ",\n".join(lines)
    text = f"""-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

-- Generated by scripts/biblio/biblio.py from biblio/references.json: do not edit.

/-- A bibliographic entry: key, formatted text (flag: italic), DOI, URL. -/
abbrev SpecBib.Entry := String × List (Bool × String) × Option String × Option String

/-- The works cited by the specification. -/
def SpecBib.entries : Array SpecBib.Entry := #[
{body}
]
"""
    Path(out).write_text(text, encoding="utf-8")
    print(f"{len(data)} notices écrites dans {out}")


if __name__ == "__main__":
    if len(sys.argv) == 5 and sys.argv[1] == "slim":
        slim(sys.argv[2], sys.argv[3], sys.argv[4])
    elif len(sys.argv) == 4 and sys.argv[1] == "lean":
        gen_lean(sys.argv[2], sys.argv[3])
    else:
        print(__doc__)
        sys.exit(2)
