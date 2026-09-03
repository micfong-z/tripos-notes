import { createHash } from "node:crypto";
import { cp, mkdir, mkdtemp, readFile, readdir, rename, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import path from "node:path";
import { gzipSync } from "node:zlib";
import { build } from "esbuild";
import type { DefaultTreeAdapterMap } from "parse5";
import { courseRoot, inCourse, listCourses } from "./load.js";
import { validate } from "./validate.js";
import { compileFragments, fragmentId, type FragmentRef } from "./fragments.js";
import { indexDocument, referencesTo, registerId, type DocumentIndex } from "./document-index.js";
import { assertTypstVersion, compileTypst } from "./typst.js";
import { accentByKind, type EntryArtifact, type PonderConfig, type PonderEntry, type PonderSection, type SourceArtifact, type SourceRef, type TooltipEntry } from "./types.js";
import { attr, hasClass, isElement, makeTocNavigationOnly, parseDocument, serialize, serializeOuter, setAttr, textContent, walk } from "./html.js";

type Element = DefaultTreeAdapterMap["element"];
type Node = DefaultTreeAdapterMap["node"];

/// Bump when document post-processing changes in a way that alters the cached
/// raw compile's usefulness.
const DOCUMENT_VERSION = "1";
const SOURCE_EXTENSIONS = new Set([".typ", ".svg", ".png", ".jpg", ".jpeg", ".gif", ".webp", ".json", ".csv", ".yml", ".yaml", ".bib", ".txt"]);
const digest = (value: string) => createHash("sha256").update(value).digest("hex");

export interface ExportOptions {
  siteRoot?: string;
  configFile?: string;
  /// Reuse compiled Typst output that is still current. Off for `--no-cache`.
  useCache?: boolean;
  /// Delete generated artifacts for ids that no longer exist in the registry.
  prune?: boolean;
  /// Report a merged index that is missing another course's shard. Suppressed
  /// for all but the last course of a `--course all` run, where the shards are
  /// still being filled in.
  warnIncompleteShards?: boolean;
}

function closestSourceBlock(element: Element): Element {
  let current: Node = element;
  while ("parentNode" in current && current.parentNode && isElement(current.parentNode)) {
    current = current.parentNode;
    if (hasClass(current, "typst-showybox") || hasClass(current, "typst-simple-callout")) return current;
  }
  return element;
}

function sourceDisplay(source: Element) {
  const block = closestSourceBlock(source);
  let title: Element | undefined;
  walk(block, (node) => {
    if (title || !isElement(node)) return;
    const classes = attr(node, "class")?.split(/\s+/) ?? [];
    if (classes.some((className) => className.startsWith("typst-") && className.endsWith("-title"))) {
      title = node;
    }
  });
  return title ? textContent(title).replace(/\s+/g, " ").trim() : "";
}

interface NativeSourceBlock {
  document: string;
  label?: string;
}

function matchingBracket(text: string, open: number) {
  let depth = 0;
  let quoted = false;
  let math = false;
  for (let index = open; index < text.length; index += 1) {
    const character = text[index];
    if (character === "\\" && (quoted || math)) {
      index += 1;
      continue;
    }
    if (character === '"') {
      quoted = !quoted;
      continue;
    }
    if (quoted) continue;
    if (character === "$") {
      math = !math;
      continue;
    }
    if (math) continue;
    if (text[index] === "[") depth += 1;
    if (text[index] === "]" && --depth === 0) return index + 1;
  }
  return -1;
}

function sourceBodyStart(text: string, commandEnd: number) {
  let parentheses = 0;
  let quoted = false;
  let math = false;
  let firstBracket = -1;
  for (let index = commandEnd; index < text.length; index += 1) {
    const character = text[index];
    if (character === "\\" && quoted) {
      index += 1;
      continue;
    }
    if (character === '"') {
      quoted = !quoted;
      continue;
    }
    if (quoted) continue;
    if (character === "$") {
      math = !math;
      continue;
    }
    if (character === "(") {
      parentheses += math ? 0 : 1;
      continue;
    }
    if (character === ")") {
      parentheses -= math ? 0 : 1;
      continue;
    }
    if (character !== "[" || parentheses !== 0) continue;
    firstBracket = index;
    break;
  }
  if (firstBracket < 0) return -1;
  const firstEnd = matchingBracket(text, firstBracket);
  if (firstEnd < 0) return -1;
  const next = text.slice(firstEnd).match(/^\s*/)?.[0].length ?? 0;
  return text[firstEnd + next] === "[" ? firstEnd + next : firstBracket;
}

function nativeSourceBlocks(text: string, document: string): NativeSourceBlock[] {
  const blocks: Array<NativeSourceBlock & { start: number; end: number }> = [];
  const command = /#(definition|theorem|proposition|lemma|corollary|law|example|axiom|solution)\b/g;
  let match: RegExpExecArray | null;
  while ((match = command.exec(text))) {
    const lineStart = text.lastIndexOf("\n", match.index - 1) + 1;
    if (text.slice(lineStart, match.index).trimStart().startsWith("//")) continue;
    const bodyStart = sourceBodyStart(text, match.index + match[0].length);
    if (bodyStart < 0) continue;
    const bodyEnd = matchingBracket(text, bodyStart);
    if (bodyEnd < 0) continue;
    if (blocks.some((block) => match!.index >= block.start && match!.index < block.end)) continue;
    const label = text.slice(bodyEnd).match(/^\s*<([A-Za-z0-9_.-]+)>/)?.[1];
    blocks.push({ document, label, start: match.index, end: bodyEnd });
  }
  return blocks.map(({ document: sourceDocument, label }) => ({ document: sourceDocument, label }));
}

async function restoreNativeSourceLabels(root: string, sourceDocument: string, index: DocumentIndex) {
  const main = await readFile(path.join(root, sourceDocument), "utf8");
  const includes = [...main.matchAll(/#include\s+"([^"]+)"/g)].map((match) => path.normalize(path.join(path.dirname(sourceDocument), match[1])));
  const sourceBlocks: NativeSourceBlock[] = [];
  for (const included of includes) {
    const text = await readFile(path.join(root, included), "utf8");
    sourceBlocks.push(...nativeSourceBlocks(text, included));
  }

  const htmlBlocks = index.sourceBlocks;
  if (sourceBlocks.length !== htmlBlocks.length) {
    throw new Error(`Native source block mapping found ${sourceBlocks.length} source blocks but ${htmlBlocks.length} HTML blocks`);
  }

  for (const [position, source] of sourceBlocks.entries()) {
    if (!source.label || index.byId.has(source.label)) continue;
    setAttr(htmlBlocks[position], "id", source.label);
    registerId(index, htmlBlocks[position], source.label);
  }
}

function warnMissingSource(entryId: string, label: string, warned: Set<string>) {
  const key = `${entryId}#${label}`;
  if (warned.has(key)) return;
  warned.add(key);
  console.warn(`${entryId}: compiled HTML is missing #${label}; continuing without that HTML block`);
}

function sectionHtml(
  index: DocumentIndex,
  fragments: Map<string, string>,
  entry: PonderEntry,
  section: PonderSection,
  warned: Set<string>,
) {
  if (section.supplemental) return fragments.get(fragmentId({ entryId: entry.id, file: section.supplemental })) ?? "";
  const source = index.byId.get(section.source!.label);
  if (!source) {
    warnMissingSource(entry.id, section.source!.label, warned);
    return "";
  }
  return serializeOuter(closestSourceBlock(source));
}

/// Fingerprints everything the course document can read, so an unchanged course
/// can reuse its previous raw compile.
async function documentFingerprint(root: string, config: PonderConfig) {
  const parts: string[] = [DOCUMENT_VERSION, config.typstVersion, config.document, config.prelude, config.htmlTheme];
  const visit = async (current: string) => {
    const listing = await readdir(current, { withFileTypes: true });
    for (const item of [...listing].sort((left, right) => left.name.localeCompare(right.name))) {
      const target = path.join(current, item.name);
      if (item.isDirectory()) await visit(target);
      else if (SOURCE_EXTENSIONS.has(path.extname(item.name).toLowerCase())) {
        parts.push(path.relative(root, target), digest(await readFile(target, "utf8").catch(() => "")));
      }
    }
  };
  // The course itself, then the shared template every course now imports.
  await visit(path.join(root, courseRoot(config)));
  await visit(path.join(root, "template"));
  return digest(parts.join(" "));
}

async function compileDocument(root: string, stagingRoot: string, config: PonderConfig, cacheDirectory: string, useCache: boolean) {
  const cache = path.join(cacheDirectory, "documents");
  const key = await documentFingerprint(root, config);
  const cached = path.join(cache, `${key}.html`);
  if (useCache) {
    const html = await readFile(cached, "utf8").catch(() => undefined);
    if (html !== undefined) return { html, reused: true };
  }
  const output = path.join(stagingRoot, `${config.course}.raw.html`);
  await compileTypst(path.join(stagingRoot, config.document), output, stagingRoot, {
    fontPath: path.join(root, "fonts"),
    theme: config.htmlTheme,
  });
  const html = await readFile(output, "utf8");
  await mkdir(cache, { recursive: true });
  const temporary = `${cached}.${process.pid}`;
  await writeFile(temporary, html);
  await rename(temporary, cached);
  return { html, reused: false };
}

async function writeAtomic(file: string, contents: string) {
  const temporary = `${file}.${process.pid}.tmp`;
  await writeFile(temporary, contents);
  await rename(temporary, file);
}

/// The merged index is a pure function of the per-course shards, so two courses
/// exporting at once converge instead of overwriting each other, and an entry
/// deleted from a course disappears instead of lingering forever.
export async function mergeTooltipShards(shardDirectory: string, mergedFile: string, expectedCourses: string[], warnIncomplete: boolean) {
  const files = (await readdir(shardDirectory).catch(() => [] as string[]))
    .filter((file) => file.endsWith(".json"))
    .sort();
  const merged: Record<string, TooltipEntry> = {};
  for (const file of files) {
    Object.assign(merged, JSON.parse(await readFile(path.join(shardDirectory, file), "utf8")) as Record<string, TooltipEntry>);
  }
  const sorted = Object.fromEntries(Object.keys(merged).sort().map((key) => [key, merged[key]]));
  const json = `${JSON.stringify(sorted)}\n`;
  await writeAtomic(mergedFile, json);

  const present = new Set(files.map((file) => path.basename(file, ".json")));
  const missing = expectedCourses.filter((course) => !present.has(course));
  if (missing.length && warnIncomplete) {
    console.warn(`${mergedFile} is missing ${missing.join(", ")}; run pnpm ponder:export -- --course all to rebuild every shard`);
  }
  return { json, entries: Object.keys(sorted).length };
}

/// Removes generated artifacts whose id is absent from the shared registry.
/// Only ever touches ids that no entry claims, never a whole directory.
export async function pruneArtifacts(directory: string, known: Set<string>) {
  const files = (await readdir(directory).catch(() => [] as string[])).filter((file) => file.endsWith(".json"));
  const removed: string[] = [];
  for (const file of files) {
    const id = path.basename(file, ".json");
    if (known.has(id)) continue;
    await rm(path.join(directory, file), { force: true });
    removed.push(id);
  }
  return removed;
}

export async function exportPonder(root: string, options: ExportOptions = {}) {
  const { configFile = "ponder/config.yml", siteRoot, useCache = true, prune = false, warnIncompleteShards = true } = options;
  const { config, entries, referenceTargets } = await validate(root, configFile);
  const courseDirectory = courseRoot(config);
  const courseEntries = entries.filter((entry) => {
    const documents = [entry.primarySource.document, ...entry.sections.flatMap((section) => section.source ? [section.source.document] : [])];
    return documents.some((document) => inCourse(document, courseDirectory));
  });
  const courseReferenceTargets = new Map(
    [...referenceTargets].filter(([key]) => key.startsWith(`${courseDirectory}/`) || key.startsWith(`${courseDirectory}#`)),
  );
  await assertTypstVersion(config.typstVersion);

  const stagingRoot = await mkdtemp(path.join(tmpdir(), "ponder-export-"));
  const dist = path.join(root, "ponder/dist");
  const cacheDirectory = path.join(dist, ".cache");
  try {
    // Fragments are inlined into a generated document rather than included, so
    // staging needs the course, the shared template it imports, and the
    // fragment preamble. The HTML flavour now comes from `--input target=html`
    // rather than swapping one template file over another.
    await mkdir(path.dirname(path.join(stagingRoot, courseDirectory)), { recursive: true });
    await cp(path.join(root, courseDirectory), path.join(stagingRoot, courseDirectory), { recursive: true });
    await cp(path.join(root, "template"), path.join(stagingRoot, "template"), { recursive: true });
    await mkdir(path.join(stagingRoot, "ponder"), { recursive: true });
    await cp(path.join(root, "ponder/fragment-preamble.typ"), path.join(stagingRoot, "ponder/fragment-preamble.typ"));

    const { html: rawHtml, reused } = await compileDocument(root, stagingRoot, config, cacheDirectory, useCache);
    const document = parseDocument(rawHtml);
    makeTocNavigationOnly(document);
    const index = indexDocument(document);
    await restoreNativeSourceLabels(root, config.document, index);

    // The concept kind is derived data, so it is stamped here from the shared
    // registry instead of being baked into the Typst source. Entries owned by
    // another course are resolved too: courses cross-reference each other.
    const entriesById = new Map(entries.map((entry) => [entry.id, entry]));
    for (const anchor of index.ponderAnchors) {
      const id = attr(anchor, "data-ponder-id")!;
      const entry = entriesById.get(id);
      if (!entry) throw new Error(`${config.document}: #ponder("${id}") has no entry in ponder/entries`);
      setAttr(anchor, "data-ponder-kind", entry.kind);
    }

    const mapping = new Map<string, PonderEntry>();
    for (const entry of courseEntries) mapping.set(entry.primarySource.label, entry);
    for (const [key, id] of courseReferenceTargets) {
      const label = key.slice(key.lastIndexOf("#") + 1);
      const entry = courseEntries.find((candidate) => candidate.id === id);
      if (entry) mapping.set(label, entry);
    }

    const originalReferenceState = [...index.anchorsByHref.values()].flat();
    for (const [label, entry] of mapping) {
      for (const reference of referencesTo(index, label)) {
        setAttr(reference.element, "data-ponder-id", entry.id);
        setAttr(reference.element, "data-ponder-kind", entry.kind);
        setAttr(reference.element, "data-ponder-reference", "true");
      }
    }

    for (const reference of originalReferenceState) {
      if (attr(reference.element, "href") !== reference.href || textContent(reference.element) !== reference.rawText) {
        throw new Error(`Reference mutation detected for ${reference.href}`);
      }
    }

    const fragmentRefs: FragmentRef[] = [];
    for (const entry of courseEntries) {
      fragmentRefs.push({ entryId: entry.id, file: entry.summary });
      for (const section of entry.sections) {
        if (section.supplemental) fragmentRefs.push({ entryId: entry.id, file: section.supplemental });
      }
    }
    const fragments = await compileFragments({
      root,
      stagingRoot,
      typstVersion: config.typstVersion,
      theme: config.htmlTheme,
      cacheDirectory,
      useCache,
    }, fragmentRefs);

    const artifacts: EntryArtifact[] = [];
    const warnedMissingSources = new Set<string>();
    for (const entry of courseEntries) {
      if (!index.byId.has(entry.primarySource.label)) {
        warnMissingSource(entry.id, entry.primarySource.label, warnedMissingSources);
      }
      const summaryHtml = fragments.html.get(fragmentId({ entryId: entry.id, file: entry.summary })) ?? "";
      const sourceSpecs: Array<{
        source: SourceRef;
        role: SourceArtifact["role"];
        variant?: string;
      }> = [{ source: entry.primarySource, role: "primary" }];
      for (const section of entry.sections) {
        if (section.source) sourceSpecs.push({ source: section.source, role: "supporting" });
      }
      for (const [variant, value] of Object.entries(entry.variants ?? {})) {
        if (value.primarySource) sourceSpecs.push({ source: value.primarySource, role: "variant", variant });
      }

      const seenSources = new Set<string>();
      const sources: SourceArtifact[] = [];
      for (const spec of sourceSpecs) {
        const key = `${spec.source.document}#${spec.source.label}`;
        if (seenSources.has(key)) continue;
        seenSources.add(key);
        const target = index.byId.get(spec.source.label);
        if (!target) warnMissingSource(entry.id, spec.source.label, warnedMissingSources);
        sources.push({
          document: spec.source.document,
          label: spec.source.label,
          role: spec.role,
          ...(spec.variant ? { variant: spec.variant } : {}),
          href: `${config.sourceBase}#${spec.source.label}`,
          display: target ? sourceDisplay(target) || entry.title : entry.title,
          heading: target ? index.headingFor.get(target) ?? "" : "",
        });
      }
      const artifact: EntryArtifact = {
        id: entry.id,
        kind: entry.kind,
        accent: accentByKind[entry.kind],
        title: entry.title,
        ...(entry.wikidataQID ? { wikidataQID: entry.wikidataQID } : {}),
        aliases: entry.aliases,
        summaryHtml,
        href: `${config.canonicalBase}/${entry.id}`,
        sources,
        tags: entry.tags,
        related: entry.related.map((id) => ({ id, title: entriesById.get(id)!.title })),
        variants: entry.variants ?? {},
        sections: [],
        referredTo: referencesTo(index, entry.primarySource.label).map(({ href, text }) => ({ href, text })),
      };
      for (const section of entry.sections) {
        const isPrimarySource = Boolean(
          section.source &&
          section.source.document === entry.primarySource.document &&
          section.source.label === entry.primarySource.label,
        );
        artifact.sections.push({
          title: section.title,
          kind: section.kind,
          accent: accentByKind[section.kind],
          html: sectionHtml(index, fragments.html, entry, section, warnedMissingSources),
          isPrimarySource,
        });
      }
      artifacts.push(artifact);
    }

    const tooltipIndex: Record<string, TooltipEntry> = Object.fromEntries(artifacts.map((artifact) => [artifact.id, {
      id: artifact.id,
      kind: artifact.kind,
      accent: artifact.accent,
      title: artifact.title,
      aliases: artifact.aliases,
      summaryHtml: artifact.summaryHtml,
      href: artifact.href,
      sources: artifact.sources,
    }]));
    const indexJson = `${JSON.stringify(tooltipIndex)}\n`;
    const indexGzip = gzipSync(indexJson).byteLength;
    if (indexGzip > config.budgets.tooltipIndexGzip) throw new Error(`Tooltip index is ${indexGzip} bytes gzip (budget ${config.budgets.tooltipIndexGzip})`);

    await mkdir(path.join(dist, "entries"), { recursive: true });
    await mkdir(path.join(dist, "tooltip"), { recursive: true });
    const enrichedHtml = serialize(document).replace(/[ \t]+$/gm, "");
    const baseDocumentGrowthPercent = ((gzipSync(enrichedHtml).byteLength / gzipSync(rawHtml).byteLength) - 1) * 100;
    if (baseDocumentGrowthPercent > config.budgets.baseDocumentGrowthPercent) {
      throw new Error(`Base document grew ${baseDocumentGrowthPercent.toFixed(2)}% gzip (budget ${config.budgets.baseDocumentGrowthPercent}%)`);
    }
    await writeFile(path.join(dist, config.outputName), enrichedHtml);
    await writeAtomic(path.join(dist, "tooltip", `${config.course}.json`), indexJson);
    for (const artifact of artifacts) await writeFile(path.join(dist, "entries", `${artifact.id}.json`), `${JSON.stringify(artifact)}\n`);

    const courses = await listCourses(root);
    const knownIds = new Set(entries.map((entry) => entry.id));
    const pruned = prune ? await pruneArtifacts(path.join(dist, "entries"), knownIds) : [];
    const merged = await mergeTooltipShards(path.join(dist, "tooltip"), path.join(dist, "tooltip-index.json"), courses, warnIncompleteShards);

    const clientResult = await build({
      entryPoints: [path.join(root, "ponder/web/ponder-controller.ts")],
      bundle: true,
      minify: true,
      write: false,
      platform: "browser",
      format: "esm",
    });
    const clientGzip = gzipSync(clientResult.outputFiles[0].contents).byteLength;
    if (clientGzip > config.budgets.clientJavaScriptGzip) throw new Error(`Controller is ${clientGzip} bytes gzip (budget ${config.budgets.clientJavaScriptGzip})`);

    const mergedGzip = gzipSync(merged.json).byteLength;
    if (config.budgets.tooltipIndexMergedGzip && mergedGzip > config.budgets.tooltipIndexMergedGzip) {
      console.warn(`Merged tooltip index is ${mergedGzip} bytes gzip across ${merged.entries} entries (soft budget ${config.budgets.tooltipIndexMergedGzip})`);
    }

    const metrics = {
      entries: artifacts.length,
      tooltipIndexGzip: indexGzip,
      clientJavaScriptGzip: clientGzip,
      baseDocumentGrowthPercent: Number(baseDocumentGrowthPercent.toFixed(3)),
      mappedReferences: originalReferenceState.filter((reference) => attr(reference.element, "data-ponder-reference") === "true").length,
      tooltipIndexMergedGzip: mergedGzip,
      mergedEntries: merged.entries,
      fragmentsCompiled: fragments.compiled,
      fragmentsCached: fragments.cached,
      documentReused: reused,
      ...(pruned.length ? { pruned } : {}),
    };
    await writeFile(path.join(dist, "metrics.json"), `${JSON.stringify(metrics, null, 2)}\n`);

    if (siteRoot) {
      const target = path.join(siteRoot, config.siteDirectory ?? "_notes/IA");
      await mkdir(path.join(target, "ponder/entries"), { recursive: true });
      await mkdir(path.join(target, "ponder/tooltip"), { recursive: true });
      await cp(path.join(dist, config.outputName), path.join(target, config.outputName));
      await writeAtomic(path.join(target, "ponder/tooltip", `${config.course}.json`), indexJson);
      await cp(path.join(dist, "entries"), path.join(target, "ponder/entries"), { recursive: true });
      if (prune) await pruneArtifacts(path.join(target, "ponder/entries"), knownIds);
      await mergeTooltipShards(path.join(target, "ponder/tooltip"), path.join(target, "ponder/tooltip-index.json"), courses, warnIncompleteShards);
    }
    if (pruned.length) console.warn(`Pruned ${pruned.length} artifact(s) for ids no longer in the registry: ${pruned.join(", ")}`);
    return metrics;
  } finally {
    await rm(stagingRoot, { recursive: true, force: true });
  }
}
