// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Reads what the K definition of `lexicon/syntax/refusals.k` says about a text.
 *
 * `krun --output json` prints the final configuration as KAST JSON. The refusals are the
 * `refusal(Code, Message)` terms of the `<k>` cell, in the order of the text; a well layered
 * text leaves none. A text that is not even well bracketed is refused by the parser, which
 * names no code.
 */

export interface Refusal {
  code: string;
  message: string;
}

export type Reading =
  | { kind: "read"; refusals: Refusal[] }
  | { kind: "unreadable"; detail: string };

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

/** The refusals of a KAST JSON document, in document order. */
export function refusalsOf(json: unknown): Refusal[] {
  const found: Refusal[] = [];
  const visit = (node: KNode | undefined): void => {
    if (node === undefined || typeof node !== "object") return;
    if (node.node === "KApply" && node.label?.name === "refusal") {
      const code = codeOf(node.args?.[0]);
      const message = messageOf(node.args?.[1]);
      if (code === undefined || message === undefined) {
        throw new Error(`malformed refusal term: ${JSON.stringify(node)}`);
      }
      found.push({ code, message });
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
    return { kind: "unreadable", detail: detail || `krun exited with status ${output.code}` };
  }
  return { kind: "read", refusals: refusalsOf(JSON.parse(stdout)) };
}
