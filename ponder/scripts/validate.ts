import { access, readFile } from "node:fs/promises";
import path from "node:path";
import { courseRoot, inCourse, loadConfig, loadEntryRegistry } from "./load.js";
import { kinds, type PonderConfig, type PonderEntry, type SourceRef } from "./types.js";

const idPattern = /^[a-z][a-z0-9]*(?:[.-][a-z0-9]+)+$/;
const variantPattern = /^[a-z][a-z0-9-]*$/;
const wikidataPattern = /^Q[1-9][0-9]*$/;
const annotationPattern = /#ponder\(\s*"([^"]+)"/g;
const allowedKinds = new Set<string>(kinds);

/// An error together with the entries it concerns, so that a course-scoped run
/// can report only what its own course is responsible for.
interface ScopedError {
  message: string;
  ids: string[];
}

export interface ValidateOptions {
  /// Validate the whole shared registry instead of just the selected course.
  all?: boolean;
}

export interface ValidateResult {
  config: PonderConfig;
  entries: PonderEntry[];
  referenceTargets: Map<string, string>;
  ownedIds: Set<string>;
  annotatedIds: Set<string>;
  courseIds: Set<string>;
  notes: string[];
}

const identity = (entry: PonderEntry) => entry.id ?? path.basename(entry.directory);

/// Entries are read repeatedly for their sources, so keep each document in
/// memory. This used to be one full file read per source reference.
function documentReader(root: string) {
  const cache = new Map<string, Promise<string | null>>();
  return (document: string) => {
    let text = cache.get(document);
    if (!text) {
      text = readFile(path.resolve(root, document), "utf8").catch(() => null);
      cache.set(document, text);
    }
    return text;
  };
}

export async function validate(
  root: string,
  configFile = "ponder/config.yml",
  options: ValidateOptions = {},
): Promise<ValidateResult> {
  const config = await loadConfig(root, configFile);
  const { entries, failures } = await loadEntryRegistry(root);
  const read = documentReader(root);
  const errors: ScopedError[] = [];
  const notes: string[] = [];
  const fail = (message: string, ...ids: Array<string | undefined>) => {
    errors.push({ message, ids: ids.filter((id): id is string => typeof id === "string") });
  };
  const requireString = (value: unknown, field: string, id?: string) => {
    if (typeof value !== "string" || value.trim() === "") fail(`${field} must be a non-empty string`, id);
  };

  const root_ = courseRoot(config);
  const owns = (entry: PonderEntry) => [
    entry.primarySource?.document,
    ...(Array.isArray(entry.sections) ? entry.sections.flatMap((section) => section.source ? [section.source.document] : []) : []),
  ].some((document) => typeof document === "string" && inCourse(document, root_));

  const ownedIds = new Set(entries.filter(owns).map(identity));
  const annotatedIds = new Set<string>();
  const annotationSites = new Map<string, string>();
  for (const document of [...config.batchDocuments, config.document]) {
    const text = await read(document);
    if (text === null) continue;
    for (const match of text.matchAll(annotationPattern)) {
      annotatedIds.add(match[1]);
      if (!annotationSites.has(match[1])) annotationSites.set(match[1], document);
    }
  }
  const courseIds = new Set([...ownedIds, ...annotatedIds]);
  const concerns = (id: string) => courseIds.has(id);

  // Configuration problems always belong to the selected course.
  const configErrors: string[] = [];
  if (config.typstVersion !== "0.14.2") configErrors.push(`${configFile} must pin Typst 0.14.2`);
  if (typeof config.sourceBase !== "string" || config.sourceBase.trim() === "") {
    configErrors.push(`${configFile} sourceBase must be a non-empty string`);
  }

  const validateSource = async (entry: PonderEntry, source: SourceRef, field: string) => {
    const id = identity(entry);
    requireString(source?.document, `${entry.id}.${field}.document`, id);
    requireString(source?.label, `${entry.id}.${field}.label`, id);
    if (source?.kind && !allowedKinds.has(source.kind)) fail(`${entry.id}.${field}.kind is invalid: ${source.kind}`, id);
    if (!source?.document || !source?.label) return;
    const documentPath = path.resolve(root, source.document);
    if (!documentPath.startsWith(`${path.resolve(root)}${path.sep}`)) {
      fail(`${entry.id}.${field}.document escapes the repository`, id);
      return;
    }
    const text = await read(source.document);
    if (text === null) fail(`${entry.id}.${field}.document does not exist: ${source.document}`, id);
    else if (!text.includes(`<${source.label}>`)) {
      fail(`${entry.id}.${field} references missing label <${source.label}> in ${source.document}`, id);
    }
  };

  const ids = new Set<string>();
  const referenceTargets = new Map<string, string>();

  for (const entry of entries) {
    const id = identity(entry);
    // Foreign entries still contribute their ids and reference targets, but
    // their internal problems are not this course's to fix.
    const inspect = options.all || concerns(id);

    if (inspect) {
      if (!idPattern.test(entry.id)) fail(`${entry.id || entry.directory}: invalid global id`, id);
      if (path.basename(entry.directory) !== entry.id) fail(`${entry.id}: directory name must equal id`, id);
      if (!allowedKinds.has(entry.kind)) fail(`${entry.id}: invalid kind ${entry.kind}`, id);
      requireString(entry.title, `${entry.id}.title`, id);
      if (entry.wikidataQID !== undefined && !wikidataPattern.test(entry.wikidataQID)) {
        fail(`${entry.id}.wikidataQID must be a Wikidata QID such as Q83478`, id);
      }
      if (!Array.isArray(entry.aliases)) fail(`${entry.id}.aliases must be an array`, id);
      if (!Array.isArray(entry.tags)) fail(`${entry.id}.tags must be an array`, id);
      if (!Array.isArray(entry.sections) || entry.sections.length === 0) fail(`${entry.id}.sections must not be empty`, id);
      if (!Array.isArray(entry.related)) fail(`${entry.id}.related must be an array`, id);

      await validateSource(entry, entry.primarySource, "primarySource");
      try { await access(path.join(entry.directory, entry.summary)); }
      catch { fail(`${entry.id}.summary does not exist: ${entry.summary}`, id); }
    }

    if (ids.has(entry.id)) fail(`${entry.id}: duplicate id`, id);
    ids.add(entry.id);

    if (entry.primarySource?.document && entry.primarySource?.label) {
      const primaryKey = `${entry.primarySource.document}#${entry.primarySource.label}`;
      const existing = referenceTargets.get(primaryKey);
      if (existing && existing !== entry.id) fail(`${primaryKey} maps to both ${existing} and ${entry.id}`, existing, id);
      referenceTargets.set(primaryKey, entry.id);
    }

    for (const [index, section] of (Array.isArray(entry.sections) ? entry.sections : []).entries()) {
      if (inspect) {
        if (!allowedKinds.has(section.kind)) fail(`${entry.id}.sections[${index}]: invalid kind ${section.kind}`, id);
        if ((section.source ? 1 : 0) + (section.supplemental ? 1 : 0) !== 1) {
          fail(`${entry.id}.sections[${index}] must have exactly one source or supplemental`, id);
        }
        if (section.source) await validateSource(entry, section.source, `sections[${index}].source`);
        if (section.supplemental) {
          try { await access(path.join(entry.directory, section.supplemental)); }
          catch { fail(`${entry.id}.sections[${index}] missing ${section.supplemental}`, id); }
        }
      }
      if (section.source?.referenceTarget && section.source.document && section.source.label) {
        const key = `${section.source.document}#${section.source.label}`;
        const mapped = referenceTargets.get(key);
        if (mapped && mapped !== entry.id) fail(`${key} maps to both ${mapped} and ${entry.id}`, mapped, id);
        referenceTargets.set(key, entry.id);
      }
    }

    if (inspect) {
      for (const [variant, value] of Object.entries(entry.variants ?? {})) {
        if (!variantPattern.test(variant)) fail(`${entry.id}: invalid variant ${variant}`, id);
        requireString(value.title, `${entry.id}.variants.${variant}.title`, id);
        requireString(value.description, `${entry.id}.variants.${variant}.description`, id);
        if (value.primarySource) await validateSource(entry, value.primarySource, `variants.${variant}.primarySource`);
      }
    }
  }

  for (const entry of entries) {
    for (const related of entry.related ?? []) {
      if (!ids.has(related)) fail(`${entry.id}: related id does not exist: ${related}`, identity(entry), related);
      if (related === entry.id) fail(`${entry.id}: entry cannot relate to itself`, identity(entry));
    }
  }

  // Replaces the compile-time dictionary lookup that used to make an
  // unregistered id panic Typst, in both HTML and PDF builds.
  for (const id of annotatedIds) {
    if (!ids.has(id)) fail(`${annotationSites.get(id)}: #ponder("${id}") has no entry in ponder/entries`, id);
  }

  const entriesById = new Map(entries.map((entry) => [entry.id, entry]));
  for (const id of annotatedIds) {
    const entry = entriesById.get(id);
    if (!entry || ownedIds.has(id)) continue;
    const owner = courseRoot({ document: entry.primarySource?.document ?? "" });
    try { await access(path.join(root, "ponder/dist/entries", `${id}.json`)); }
    catch { notes.push(`${id} is annotated here but owned by ${owner}; export that course so its entry artifact exists`); }
  }

  for (const failure of failures) {
    const message = `${failure.directory}: entry.yml could not be read: ${failure.message}`;
    if (options.all || concerns(failure.directory)) fail(message, failure.directory);
    else notes.push(message);
  }

  const reported = [
    ...configErrors.map((message) => ({ message, ids: [] as string[] })),
    ...(options.all ? errors : errors.filter((error) => error.ids.some(concerns))),
  ];
  if (reported.length) {
    throw new Error(`Ponder validation failed:\n- ${reported.map((error) => error.message).join("\n- ")}`);
  }
  return { config, entries, referenceTargets, ownedIds, annotatedIds, courseIds, notes };
}
