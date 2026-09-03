import { createHash } from "node:crypto";
import { mkdir, readFile, rename, rm, writeFile } from "node:fs/promises";
import path from "node:path";
import { bodyHtml, parseDocument } from "./html.js";
import { compileTypst } from "./typst.js";

/// Bump when the generated wrapper document changes shape, so that HTML cached
/// under an older wrapper is never reused.
const WRAPPER_VERSION = "2";
const FRAGMENTS_PER_DOCUMENT = 256;
const marker = (index: number | "end") => `ponder-fragment-${index}`;
const markerPattern = /<hr id="ponder-fragment-(?:\d+|end)">/g;
const digest = (value: string) => createHash("sha256").update(value).digest("hex");

export interface FragmentRef {
  entryId: string;
  file: string;
}

export interface FragmentOptions {
  root: string;
  stagingRoot: string;
  typstVersion: string;
  /// Colour scheme for the HTML export, forwarded to the Typst compile.
  theme: string;
  cacheDirectory: string;
  useCache: boolean;
}

export const fragmentId = (fragment: FragmentRef) => `${fragment.entryId}/${fragment.file}`;

async function readLocalImports(root: string, file: string, seen: Set<string>, texts: string[]) {
  if (seen.has(file)) return;
  seen.add(file);
  let text: string;
  try {
    text = await readFile(path.join(root, file), "utf8");
  } catch {
    return;
  }
  texts.push(`${file}\n${text}`);
  const directory = path.dirname(file);
  for (const match of text.matchAll(/#import\s+"([^"@][^"]*)"/g)) {
    // Typst resolves a leading "/" against the project root, not the importer,
    // so joining it onto the directory would look in the wrong place and the
    // cache key would stop tracking the shared template.
    const target = match[1].startsWith("/")
      ? match[1].slice(1)
      : path.normalize(path.join(directory, match[1]));
    await readLocalImports(root, target, seen, texts);
  }
}

/// Everything outside a fragment itself that can change its compiled HTML: the
/// Typst version, the wrapper shape, the template with whatever it imports
/// locally, and the shared preamble. A Typst *package* upgrade is invisible
/// here, which is what `--no-cache` is for.
export async function environmentKey(options: FragmentOptions) {
  const texts: string[] = [];
  await readLocalImports(options.root, "template/lib.typ", new Set(), texts);
  await readLocalImports(options.root, "ponder/fragment-preamble.typ", new Set(), texts);
  return digest([options.typstVersion, WRAPPER_VERSION, options.theme, ...texts].join(" "));
}

/// Fragments are course-independent: an entry's summary is authored against the
/// shared notation in `fragment-preamble.typ`, not a single course's prelude.
export function wrapperDocument(group: Array<{ text: string }>) {
  const lines = [
    `#import "/template/lib.typ": *`,
    `#import "/ponder/fragment-preamble.typ": *`,
    `#show: project`,
  ];
  for (const [index, entry] of group.entries()) {
    lines.push("", `#html.elem("hr", attrs: (id: "${marker(index)}"))`, "", entry.text.trim());
  }
  lines.push("", `#html.elem("hr", attrs: (id: "${marker("end")}"))`, "");
  return `${lines.join("\n")}\n`;
}

/// Recovers the individual fragments from a compiled group by cutting at the
/// marker elements.
export function splitFragmentDocument(body: string, count: number) {
  const parts = body.split(markerPattern);
  if (parts.length !== count + 2) {
    throw new Error(`Fragment document produced ${parts.length - 2} sections for ${count} fragments`);
  }
  return parts.slice(1, -1).map((part) => part.trim());
}

/// Compiles a group of fragments as one Typst document, separated by marker
/// elements at top level. Each fragment sees exactly the scope and block
/// context it would get from its own compile, which keeps the output
/// byte-identical to compiling them one at a time.
async function compileGroup(options: FragmentOptions, group: Array<{ text: string }>, suffix: string) {
  const wrapper = path.join(options.stagingRoot, `.ponder-fragments-${suffix}.typ`);
  const output = `${wrapper}.html`;
  await writeFile(wrapper, wrapperDocument(group));
  try {
    await compileTypst(wrapper, output, options.stagingRoot, {
      fontPath: path.join(options.root, "fonts"),
      theme: options.theme,
    });
    return splitFragmentDocument(bodyHtml(parseDocument(await readFile(output, "utf8"))), group.length);
  } finally {
    await rm(wrapper, { force: true });
    await rm(output, { force: true });
  }
}

/// Recompiles each fragment alone so that a batch failure still names the file
/// that caused it. Batching must not cost us usable error messages.
async function attributeFailure(
  options: FragmentOptions,
  group: Array<{ text: string; fragment: FragmentRef }>,
  failure: unknown,
): Promise<never> {
  for (const entry of group) {
    try {
      await compileGroup(options, [entry], "probe");
    } catch (error) {
      throw new Error(`${fragmentId(entry.fragment)} failed to compile:\n${error instanceof Error ? error.message : String(error)}`);
    }
  }
  throw failure;
}

/// Resolves every fragment to its compiled HTML, reading what it can from the
/// content-addressed cache and compiling the rest in as few Typst processes as
/// possible. Returns a map keyed by `<entry-id>/<file>`.
export async function compileFragments(options: FragmentOptions, fragments: FragmentRef[]) {
  const unique = new Map<string, FragmentRef>();
  for (const fragment of fragments) unique.set(fragmentId(fragment), fragment);

  const environment = await environmentKey(options);
  const cache = path.join(options.cacheDirectory, "fragments");
  await mkdir(cache, { recursive: true });

  const html = new Map<string, string>();
  const misses: Array<{ text: string; fragment: FragmentRef; key: string; id: string }> = [];
  for (const [id, fragment] of unique) {
    // Trimmed, because the wrapper trims too: whitespace-only edits must not
    // invalidate a fragment whose compiled output cannot change.
    const text = (await readFile(path.join(options.root, "ponder/entries", fragment.entryId, fragment.file), "utf8")).trim();
    const key = digest(`${environment} ${text}`);
    if (options.useCache) {
      try {
        html.set(id, await readFile(path.join(cache, `${key}.html`), "utf8"));
        continue;
      } catch (error) {
        if ((error as NodeJS.ErrnoException).code !== "ENOENT") throw error;
      }
    }
    misses.push({ text, fragment, key, id });
  }

  for (let start = 0; start < misses.length; start += FRAGMENTS_PER_DOCUMENT) {
    const group = misses.slice(start, start + FRAGMENTS_PER_DOCUMENT);
    let compiled: string[];
    try {
      compiled = await compileGroup(options, group, String(start));
    } catch (error) {
      compiled = await attributeFailure(options, group, error);
    }
    for (const [index, entry] of group.entries()) {
      html.set(entry.id, compiled[index]);
      // Content addressed, so a concurrent export writes identical bytes; the
      // rename still keeps a reader from ever seeing a partial file.
      const destination = path.join(cache, `${entry.key}.html`);
      const temporary = `${destination}.${process.pid}.${start + index}`;
      await writeFile(temporary, compiled[index]);
      await rename(temporary, destination);
    }
  }

  return { html, compiled: misses.length, cached: unique.size - misses.length };
}
