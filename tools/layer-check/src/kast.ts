// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Reads what the K readers of `lexicon/syntax/` say about a text.
 *
 * `krun --output json` prints the final configuration as KAST JSON. The refusals are the
 * `refusal(Code, Message)` terms of the `<k>` cell, in the order of the text; a text read
 * without fault leaves none. The balance reader (`balance.k`) wraps each refusal in
 * `located(Refusal, Site)`, where the site names the delimiter at fault and its line:
 * `at(Pair, Line)`, or `meets(Pair, Line, Pair, Line)` for a closing delimiter that meets an
 * open delimiter of another pair. The tree reader (`refusals.k`) gives no site, and refuses a
 * text whose delimiters do not pair as a parse failure, which names no code.
 */

export interface Refusal {
  code: string;
  message: string;
  /** Line of the delimiter at fault, 1-based in the text read, when the reader gives one. */
  line?: number;
  /** The delimiter at fault, and for a closing delimiter of another pair the one it meets. */
  site?: string;
}

export type KFailureKind = "parse" | "execution";

export type Reading =
  | { kind: "read"; refusals: Refusal[] }
  | { kind: "unreadable"; failure: KFailureKind; detail: string };

const PARSE_FAILURE =
  /\bparse error\b|\bsyntax error\b|\bparsing failed\b|\bfailed to parse\b|\bunexpected token\b/i;

/** Classifies a non-zero K process exit without treating arbitrary failures as parse errors. */
export function classifyKFailure(output: string): KFailureKind {
  return PARSE_FAILURE.test(output) ? "parse" : "execution";
}

interface KNode {
  node?: string;
  label?: { name?: string };
  args?: KNode[];
  items?: KNode[];
  term?: KNode;
  token?: string;
}

const CODE = /ERR-[A-Z]+-\d+/;

function codeOf(node: KNode | undefined): string | undefined {
  const name = node?.label?.name;
  return name === undefined ? undefined : CODE.exec(name)?.[0];
}

function messageOf(node: KNode | undefined): string | undefined {
  const token = node?.node === "KToken" ? node.token : undefined;
  if (token === undefined || token.length < 2 || !token.startsWith('"') || !token.endsWith('"')) {
    return undefined;
  }
  return token.slice(1, -1);
}

const OPENING: Record<string, string> = { square: "[", paren: "(", brace: "{", quote: '"' };
const CLOSING: Record<string, string> = { square: "]", paren: ")", brace: "}" };
/** Codes whose site is a closing delimiter; every other site is an opening one. */
const AT_CLOSER = new Set(["ERR-DLM-002", "ERR-DLM-003"]);

function lineOf(node: KNode | undefined): number | undefined {
  const token = node?.node === "KToken" ? node.token : undefined;
  return token !== undefined && /^\d+$/.test(token) ? Number(token) : undefined;
}

function delimiterOf(node: KNode | undefined, table: Record<string, string>): string | undefined {
  const name = node?.node === "KApply" ? node.label?.name : undefined;
  return name === undefined ? undefined : table[name];
}

function refusalOf(node: KNode): Refusal {
  const code = codeOf(node.args?.[0]);
  const message = messageOf(node.args?.[1]);
  if (code === undefined || message === undefined) {
    throw new Error(`malformed refusal term: ${JSON.stringify(node)}`);
  }
  return { code, message };
}

function located(node: KNode): Refusal {
  const inner = node.args?.[0];
  const site = node.args?.[1];
  if (inner?.node !== "KApply" || inner.label?.name !== "refusal" || site?.node !== "KApply") {
    throw new Error(`malformed located term: ${JSON.stringify(node)}`);
  }
  const refusal = refusalOf(inner);
  const table = AT_CLOSER.has(refusal.code) ? CLOSING : OPENING;
  const args = site.args ?? [];
  const delimiter = delimiterOf(args[0], table);
  const line = lineOf(args[1]);
  if (delimiter === undefined || line === undefined) {
    throw new Error(`malformed site: ${JSON.stringify(site)}`);
  }
  if (site.label?.name === "at" && args.length === 2) {
    return { ...refusal, line, site: `\`${delimiter}\` line ${line}` };
  }
  const met = delimiterOf(args[2], OPENING);
  const metLine = lineOf(args[3]);
  if (site.label?.name !== "meets" || met === undefined || metLine === undefined) {
    throw new Error(`malformed site: ${JSON.stringify(site)}`);
  }
  return {
    ...refusal,
    line,
    site: `\`${delimiter}\` line ${line} meets \`${met}\` opened line ${metLine}`,
  };
}

/** The refusals of a KAST JSON document, in document order. */
export function refusalsOf(json: unknown): Refusal[] {
  const found: Refusal[] = [];
  const visit = (node: KNode | undefined): void => {
    if (node === undefined || typeof node !== "object") return;
    if (node.node === "KApply" && node.label?.name === "located") {
      found.push(located(node));
      return;
    }
    if (node.node === "KApply" && node.label?.name === "refusal") {
      found.push(refusalOf(node));
      return;
    }
    if (node.term) visit(node.term);
    for (const child of node.args ?? []) visit(child);
    for (const child of node.items ?? []) visit(child);
  };
  visit(json as KNode);
  return found;
}

/** Runs `krun` on one file and reads its verdict. */
export async function readWithK(krun: string, definition: string, path: string): Promise<Reading> {
  const output = await new Deno.Command(krun, {
    args: ["--definition", definition, "--output", "json", path],
    stdout: "piped",
    stderr: "piped",
  }).output();
  const stdout = new TextDecoder().decode(output.stdout);
  const stderr = new TextDecoder().decode(output.stderr);
  if (output.code !== 0) {
    const detail = stderr.split("\n").filter((l) => l.trim() !== "" && !l.includes("JAVA_TOOL"))
      .slice(0, 3).join(" | ");
    return {
      kind: "unreadable",
      failure: classifyKFailure(`${stderr}\n${stdout}`),
      detail: detail || `krun exited with status ${output.code}`,
    };
  }
  return { kind: "read", refusals: refusalsOf(JSON.parse(stdout)) };
}
