// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Port of scripts/ci/k7pl_semantics_render_blueprint.sh.
 *
 * Renders the Verso Blueprint of the formal chain
 * (`lake exe vbp build`), fails when it produced no HTML
 * page, and writes the page count to the job summary.
 * The shell script runs with working-directory
 * spec/formal-chain; this port takes that directory
 * explicitly (defaulting to spec/formal-chain under the
 * repository root) and runs lake there.
 *
 * Deliberate deviation from the shell script: the original
 * writes its summary lines with `printf '%s\\n'`, which
 * prints a literal backslash-n, not a newline. This port
 * writes real newlines; the count behaviour (fail unless
 * at least one *.html file exists under
 * _out/site/html-multi) is unchanged.
 */

export interface RenderBlueprintOptions {
  /** Blueprint directory; default: <repo root>/spec/formal-chain. */
  dir?: string;
  /** Default: $GITHUB_STEP_SUMMARY. */
  stepSummary?: string;
  /** PATH for lake, defaulting to the process PATH. */
  path?: string;
}

export interface BlueprintRender {
  htmlDir: string;
  htmlCount: number;
}

function requiredEnv(name: string, override: string | undefined): string {
  if (override !== undefined) return override;
  const value = Deno.env.get(name);
  if (value === undefined) throw new Error(`${name}: unbound variable`);
  return value;
}

async function countHtml(dir: string): Promise<number> {
  let count = 0;
  for await (const entry of Deno.readDir(dir)) {
    const entryPath = `${dir}/${entry.name}`;
    if (entry.isDirectory) {
      count += await countHtml(entryPath);
    } else if (entry.isFile && entry.name.endsWith(".html")) {
      count += 1;
    }
  }
  return count;
}

async function appendText(path: string, text: string): Promise<void> {
  const file = await Deno.open(path, {
    write: true,
    append: true,
    create: true,
  });
  try {
    await file.write(new TextEncoder().encode(text));
  } finally {
    file.close();
  }
}

export async function renderBlueprint(
  options: RenderBlueprintOptions = {},
): Promise<BlueprintRender> {
  const repoRoot = new URL("../../../", import.meta.url).pathname;
  const dir = options.dir ?? `${repoRoot}spec/formal-chain`;
  const stepSummary = requiredEnv("GITHUB_STEP_SUMMARY", options.stepSummary);
  const lake = new Deno.Command("lake", {
    args: ["exe", "vbp", "build"],
    cwd: dir,
    stdout: "inherit",
    stderr: "inherit",
    env: options.path !== undefined ? { PATH: options.path } : undefined,
  });
  const { code } = await lake.output();
  if (code !== 0) {
    throw new Error(`lake exe vbp build failed with exit status ${code}`);
  }
  const htmlDir = `${dir}/_out/site/html-multi`;
  let htmlStat: Deno.FileInfo;
  try {
    htmlStat = await Deno.stat(htmlDir);
  } catch {
    throw new Error(`no HTML output directory: ${htmlDir}`);
  }
  if (!htmlStat.isDirectory) {
    throw new Error(`no HTML output directory: ${htmlDir}`);
  }
  const htmlCount = await countHtml(htmlDir);
  if (htmlCount <= 0) {
    throw new Error(`no HTML pages generated in ${htmlDir}`);
  }
  // Real newlines here: the shell script's '%s\\n' wrote a
  // literal backslash-n (see the module doc comment).
  await appendText(
    stepSummary,
    "## Verso Blueprint\n" +
      `Generated HTML files: ${htmlCount}\n` +
      "Output: spec/formal-chain/_out/site/html-multi/\n",
  );
  return { htmlDir, htmlCount };
}

if (import.meta.main) {
  try {
    await renderBlueprint();
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    Deno.exit(1);
  }
}
