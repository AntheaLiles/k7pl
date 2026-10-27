// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Minimal YAML subset parser for the component registry.
 *
 * Supported: block mappings and sequences, plain / single-quoted /
 * double-quoted scalars, booleans, integers, empty values (null),
 * and flow sequences. NOT supported, rejected with an error:
 * tabs for indentation, anchors, aliases, tags, block scalars
 * (| and >), flow mappings, and multi-line scalars. The registry
 * must stay inside this subset so that it can be parsed without
 * any runtime dependency.
 */

export type YamlValue =
  | string
  | number
  | boolean
  | null
  | YamlValue[]
  | { [key: string]: YamlValue };

interface Line {
  indent: number;
  content: string;
  number: number;
}

function parseScalar(raw: string, lineNumber: number): YamlValue {
  const text = raw.trim();
  if (text === "" || text === "~" || text === "null") return null;
  if (text === "true") return true;
  if (text === "false") return false;
  if (/^-?\d+$/.test(text)) return Number(text);
  if (text.startsWith("'") && text.endsWith("'") && text.length >= 2) {
    return text.slice(1, -1).replace(/''/g, "'");
  }
  if (text.startsWith('"') && text.endsWith('"') && text.length >= 2) {
    return text.slice(1, -1)
      .replace(/\\"/g, '"')
      .replace(/\\\\/g, "\\")
      .replace(/\\n/g, "\n");
  }
  if (text.startsWith("[")) {
    if (!text.endsWith("]")) {
      throw new Error(`yaml: line ${lineNumber}: unterminated flow sequence`);
    }
    const inner = text.slice(1, -1).trim();
    if (inner === "") return [];
    return splitFlow(inner).map((part) => parseScalar(part, lineNumber));
  }
  return text;
}

function splitFlow(inner: string): string[] {
  const parts: string[] = [];
  let current = "";
  let quote = "";
  for (const ch of inner) {
    if (quote) {
      current += ch;
      if (ch === quote) quote = "";
    } else if (ch === "'" || ch === '"') {
      quote = ch;
      current += ch;
    } else if (ch === ",") {
      parts.push(current.trim());
      current = "";
    } else {
      current += ch;
    }
  }
  if (current.trim() !== "") parts.push(current.trim());
  return parts;
}

function stripComment(content: string): string {
  let quote = "";
  for (let i = 0; i < content.length; i++) {
    const ch = content[i];
    if (quote) {
      if (ch === quote) quote = "";
    } else if (ch === "'" || ch === '"') {
      quote = ch;
    } else if (
      ch === "#" &&
      (i === 0 || content[i - 1] === " " || content[i - 1] === "\t")
    ) {
      return content.slice(0, i).trimEnd();
    }
  }
  return content;
}

/** Split a `key: value` line. Returns null when there is no top-level colon. */
function splitKey(content: string): [string, string] | null {
  let quote = "";
  for (let i = 0; i < content.length; i++) {
    const ch = content[i];
    if (quote) {
      if (ch === quote) quote = "";
    } else if (ch === "'" || ch === '"') {
      quote = ch;
    } else if (
      ch === ":" && (i + 1 === content.length || content[i + 1] === " ")
    ) {
      return [content.slice(0, i).trim(), content.slice(i + 1).trim()];
    }
  }
  return null;
}

function parseBlock(
  lines: Line[],
  pos: number,
  indent: number,
): [YamlValue, number] {
  if (pos >= lines.length) return [null, pos];
  const first = lines[pos];
  if (first.indent < indent) return [null, pos];
  if (first.content.startsWith("- ") || first.content === "-") {
    return parseSequence(lines, pos, first.indent);
  }
  return parseMapping(lines, pos, first.indent);
}

function parseSequence(
  lines: Line[],
  pos: number,
  indent: number,
): [YamlValue[], number] {
  const out: YamlValue[] = [];
  while (pos < lines.length) {
    const line = lines[pos];
    if (
      line.indent !== indent ||
      !(line.content.startsWith("- ") || line.content === "-")
    ) break;
    const rest = line.content === "-" ? "" : line.content.slice(2);
    if (rest === "") {
      const [value, next] = parseBlock(lines, pos + 1, indent + 1);
      out.push(value);
      pos = next;
    } else if (splitKey(rest) !== null) {
      // Inline first key of a mapping item: rewrite as a mapping block.
      const [key, value] = splitKey(rest)!;
      const synthetic: Line[] = [{
        indent: indent + 2,
        content: `${key}: ${value}`,
        number: line.number,
      }];
      let next = pos + 1;
      while (next < lines.length && lines[next].indent > indent) {
        synthetic.push(lines[next]);
        next++;
      }
      const [mapped, _] = parseMapping(synthetic, 0, indent + 2);
      out.push(mapped);
      pos = next;
    } else {
      // A plain scalar may fold over following, more-indented
      // lines (YAML folding: joined with single spaces).
      let scalar = rest;
      pos++;
      while (pos < lines.length && lines[pos].indent > indent) {
        scalar += ` ${lines[pos].content}`;
        pos++;
      }
      out.push(parseScalar(scalar, line.number));
    }
  }
  return [out, pos];
}

function parseMapping(
  lines: Line[],
  pos: number,
  indent: number,
): [{ [key: string]: YamlValue }, number] {
  const out: { [key: string]: YamlValue } = {};
  while (pos < lines.length) {
    const line = lines[pos];
    if (line.indent !== indent) break;
    if (line.content.startsWith("- ")) break;
    const split = splitKey(line.content);
    if (split === null) {
      throw new Error(
        `yaml: line ${line.number}: expected 'key: value', got ${
          JSON.stringify(line.content)
        }`,
      );
    }
    const [key, rest] = split;
    if (rest !== "") {
      // Folded plain scalar: following, more-indented lines
      // belong to this value, not to a sibling key.
      let scalar = rest;
      pos++;
      while (pos < lines.length && lines[pos].indent > indent) {
        scalar += ` ${lines[pos].content}`;
        pos++;
      }
      out[key] = parseScalar(scalar, line.number);
    } else {
      const [value, next] = parseBlock(lines, pos + 1, indent + 1);
      out[key] = value;
      pos = next;
    }
  }
  return [out, pos];
}

/** Parse YAML text in the supported subset. Throws on unsupported syntax. */
export function parseYaml(text: string): YamlValue {
  const rawLines = text.split("\n");
  const lines: Line[] = [];
  for (let i = 0; i < rawLines.length; i++) {
    const raw = rawLines[i];
    if (raw.includes("\t")) {
      throw new Error(
        `yaml: line ${i + 1}: tabs are not allowed for indentation`,
      );
    }
    if (/^\s*(---|\.\.\.)\s*$/.test(raw)) continue;
    const stripped = stripComment(raw);
    if (stripped.trim() === "") continue;
    const indent = stripped.length - stripped.trimStart().length;
    const content = stripped.trim();
    if (
      /^[&*!|>]/.test(content) || content.includes(" &") ||
      content.includes(" *")
    ) {
      throw new Error(
        `yaml: line ${
          i + 1
        }: anchors, aliases, tags, and block scalars are not supported`,
      );
    }
    if (content.startsWith("{")) {
      throw new Error(`yaml: line ${i + 1}: flow mappings are not supported`);
    }
    lines.push({ indent, content, number: i + 1 });
  }
  if (lines.length === 0) return null;
  const [value, consumed] = parseBlock(lines, 0, lines[0].indent);
  if (consumed !== lines.length) {
    throw new Error(
      `yaml: line ${
        lines[consumed].number
      }: unexpected content after top-level document`,
    );
  }
  return value;
}

export function asRecord(
  value: YamlValue,
  what: string,
): { [key: string]: YamlValue } {
  if (value === null || typeof value !== "object" || Array.isArray(value)) {
    throw new Error(`${what}: expected a mapping`);
  }
  return value as { [key: string]: YamlValue };
}

export function asList(value: YamlValue, what: string): YamlValue[] {
  if (!Array.isArray(value)) throw new Error(`${what}: expected a sequence`);
  return value;
}

export function asString(value: YamlValue, what: string): string {
  if (typeof value !== "string") throw new Error(`${what}: expected a string`);
  return value;
}

export function asStringList(value: YamlValue, what: string): string[] {
  return asList(value, what).map((item) => asString(item, what));
}
