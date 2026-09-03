import { createHash } from "node:crypto";
import { access, mkdir, readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import YAML from "yaml";
import { loadConfig, loadEntries } from "./load.js";
import { kinds, type PonderKind } from "./types.js";

interface SourceEdit {
  document: string;
  start: number;
  end: number;
  expected: string;
  replacement: string;
  entryId: string;
}

interface LabelEdit {
  document: string;
  start: number;
  end: number;
  expected: string;
  replacement: string;
  label: string;
}

interface ConceptProposal {
  id: string;
  kind: PonderKind;
  title: string;
  wikidataQID: string | null;
  aliases: string[];
  tags: string[];
  summaryTyp: string;
  primarySource: {
    document: string;
    label: string;
    kind: PonderKind;
  };
  related: string[];
}

interface BatchResult {
  model: string;
  promptVersion: string;
  inputHash: string;
  document: string;
  concepts: ConceptProposal[];
  labelEdits: LabelEdit[];
  edits: SourceEdit[];
}

const idPattern = /^[a-z][a-z0-9]*(?:[.-][a-z0-9]+)+$/;
const labelPattern = /^[a-z][a-z0-9-]*$/;
const wikidataPattern = /^Q[1-9][0-9]*$/;
const allowedKinds = new Set<string>(kinds);
const hash = (value: string | Buffer) => createHash("sha256").update(value).digest("hex");

const kindSchema = { type: "string", enum: [...kinds] };
const schema = {
  type: "object",
  additionalProperties: false,
  required: ["model", "promptVersion", "inputHash", "document", "concepts", "labelEdits", "edits"],
  properties: {
    model: { type: "string" },
    promptVersion: { type: "string" },
    inputHash: { type: "string" },
    document: { type: "string" },
    concepts: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["id", "kind", "title", "wikidataQID", "aliases", "tags", "summaryTyp", "primarySource", "related"],
        properties: {
          id: { type: "string" },
          kind: kindSchema,
          title: { type: "string" },
          wikidataQID: { type: ["string", "null"] },
          aliases: { type: "array", items: { type: "string" } },
          tags: { type: "array", items: { type: "string" } },
          summaryTyp: { type: "string" },
          primarySource: {
            type: "object",
            additionalProperties: false,
            required: ["document", "label", "kind"],
            properties: {
              document: { type: "string" },
              label: { type: "string" },
              kind: kindSchema,
            },
          },
          related: { type: "array", items: { type: "string" } },
        },
      },
    },
    labelEdits: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["document", "start", "end", "expected", "replacement", "label"],
        properties: {
          document: { type: "string" },
          start: { type: "integer" },
          end: { type: "integer" },
          expected: { type: "string" },
          replacement: { type: "string" },
          label: { type: "string" },
        },
      },
    },
    edits: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["document", "start", "end", "expected", "replacement", "entryId"],
        properties: {
          document: { type: "string" },
          start: { type: "integer" },
          end: { type: "integer" },
          expected: { type: "string" },
          replacement: { type: "string" },
          entryId: { type: "string" },
        },
      },
    },
  },
};

function chapterPath(
  root: string,
  document: string,
  config: { batchDocuments: string[]; document?: string },
) {
  const target = path.resolve(root, document);
  // With no explicit batchDocuments, fall back to the selected course's own
  // chapters directory rather than a hard-coded course.
  const chapters = config.document
    ? path.resolve(root, path.dirname(config.document), "chapters")
    : undefined;
  const allowed = config.batchDocuments.length > 0
    ? config.batchDocuments.some((candidate) => path.resolve(root, candidate) === target)
    : chapters !== undefined && target.startsWith(`${chapters}${path.sep}`);
  if (!allowed || path.extname(target) !== ".typ") {
    throw new Error(`${document}: operations must target a configured course document`);
  }
  return target;
}

function requireString(value: unknown, field: string) {
  if (typeof value !== "string" || value.trim() === "") throw new Error(`${field} must be a non-empty string`);
}

function requireStringArray(value: unknown, field: string) {
  if (!Array.isArray(value) || value.some((item) => typeof item !== "string" || item.trim() === "")) {
    throw new Error(`${field} must be an array of non-empty strings`);
  }
}

function assertRange(source: string, operation: { start: number; end: number; expected: string }, document: string) {
  if (!Number.isInteger(operation.start) || !Number.isInteger(operation.end) || operation.start < 0 || operation.end <= operation.start || operation.end > source.length) {
    throw new Error(`${document}: invalid edit range ${operation.start}:${operation.end}`);
  }
  if (source.slice(operation.start, operation.end) !== operation.expected) {
    throw new Error(`${document}: stale edit at ${operation.start}`);
  }
}

function assertNotInComment(source: string, start: number, document: string) {
  const lineStart = source.lastIndexOf("\n", start - 1) + 1;
  if (source.slice(lineStart, start).trimStart().startsWith("//")) {
    throw new Error(`${document}: comments may not be edited`);
  }
}

function assertEditIsSafe(source: string, edit: SourceEdit) {
  assertRange(source, edit, edit.document);
  if (edit.expected.includes("@") || edit.replacement.includes("@")) throw new Error(`${edit.document}: references may not be edited`);
  if (edit.expected.includes("`") || edit.replacement.includes("`")) throw new Error(`${edit.document}: raw code may not be edited`);
  if (edit.replacement !== `#ponder("${edit.entryId}")[${edit.expected}]`) {
    throw new Error(`${edit.document}: replacement must only wrap ${edit.entryId}`);
  }
  assertNotInComment(source, edit.start, edit.document);

  const before = source.slice(0, edit.start);
  if ((before.match(/\$/g) ?? []).length % 2 === 1) throw new Error(`${edit.document}: edits inside math are forbidden`);
  const openPonder = before.lastIndexOf("#ponder(");
  const closeBracket = before.lastIndexOf("]");
  if (openPonder > closeBracket) throw new Error(`${edit.document}: nested ponder edits are forbidden`);
}

function assertLabelEditIsSafe(source: string, edit: LabelEdit) {
  assertRange(source, edit, edit.document);
  if (!labelPattern.test(edit.label)) throw new Error(`${edit.document}: invalid label ${edit.label}`);
  if (edit.expected !== "]" || edit.replacement !== `] <${edit.label}>`) {
    throw new Error(`${edit.document}: label edits must replace ] with ] <${edit.label}>`);
  }
  if (source.includes(`<${edit.label}>`)) throw new Error(`${edit.document}: label already exists: ${edit.label}`);
  assertNotInComment(source, edit.start, edit.document);
}

function assertOperationsDoNotOverlap(result: BatchResult) {
  const operations = [
    ...result.edits.map((edit) => ({ start: edit.start, end: edit.end })),
    ...result.labelEdits.map((edit) => ({ start: edit.start, end: edit.end })),
  ].sort((left, right) => left.start - right.start);
  for (let index = 1; index < operations.length; index++) {
    if (operations[index].start < operations[index - 1].end) {
      throw new Error(`${result.document}: source operations overlap`);
    }
  }
}

function countLabel(source: string, label: string) {
  return source.split(`<${label}>`).length - 1;
}

function primarySectionTitle(kind: PonderKind) {
  if (["theorem", "proposition", "lemma", "claim", "corollary"].includes(kind)) return "Statement";
  return `${kind.charAt(0).toUpperCase()}${kind.slice(1)}`;
}

async function pathExists(target: string) {
  try {
    await access(target);
    return true;
  } catch {
    return false;
  }
}

export async function prepareBatch(root: string, output = "ponder/batches/annotation.jsonl", configFile = "ponder/config.yml") {
  const config = await loadConfig(root, configFile);
  const migration = YAML.parse(await readFile(path.join(root, "ponder/migration.yml"), "utf8"));
  const [annotationPrompt, authoringPrompt, entries] = await Promise.all([
    readFile(path.join(root, "ponder/prompts/annotation.txt"), "utf8"),
    readFile(path.join(root, "ponder/prompts/entry-authoring.txt"), "utf8"),
    loadEntries(root),
  ]);
  const registry = entries.map((entry) => ({
    id: entry.id,
    kind: entry.kind,
    title: entry.title,
    wikidataQID: entry.wikidataQID ?? null,
    aliases: entry.aliases,
    tags: entry.tags,
    primarySource: entry.primarySource,
  }));
  const lines: string[] = [];

  for (const document of config.batchDocuments) {
    const source = await readFile(path.join(root, document), "utf8");
    const inputHash = hash(source);
    lines.push(JSON.stringify({
      custom_id: `${config.course}-${path.basename(document, ".typ")}-${inputHash.slice(0, 12)}`,
      method: "POST",
      url: migration.endpoint,
      body: {
        model: migration.model,
        reasoning: { effort: "medium" },
        input: [
          { role: "developer", content: [{ type: "input_text", text: annotationPrompt }] },
          { role: "developer", content: [{ type: "input_text", text: authoringPrompt }] },
          { role: "user", content: [{ type: "input_text", text: JSON.stringify({
            model: migration.model,
            promptVersion: migration.promptVersion,
            document,
            inputHash,
            registry,
            source,
          }) }] },
        ],
        text: { format: { type: "json_schema", name: "ponder_annotation_with_concepts", strict: true, schema } },
      },
      metadata: { model: migration.model, promptVersion: migration.promptVersion, inputHash },
    }));
  }
  const destination = path.resolve(root, output);
  await mkdir(path.dirname(destination), { recursive: true });
  await writeFile(destination, `${lines.join("\n")}\n`);
  return destination;
}

export async function applyBatchResult(root: string, resultPath: string, configFile = "ponder/config.yml") {
  const config = await loadConfig(root, configFile);
  const result = JSON.parse(await readFile(path.resolve(root, resultPath), "utf8")) as BatchResult;
  requireString(result.document, "document");
  const target = chapterPath(root, result.document, config);
  const source = await readFile(target, "utf8");
  if (hash(source) !== result.inputHash) throw new Error(`${result.document}: input hash is stale`);

  for (const edit of result.edits) {
    if (edit.document !== result.document) throw new Error(`${edit.document}: edit does not match result document`);
    assertEditIsSafe(source, edit);
  }
  for (const edit of result.labelEdits) {
    if (edit.document !== result.document) throw new Error(`${edit.document}: label edit does not match result document`);
    assertLabelEditIsSafe(source, edit);
  }
  assertOperationsDoNotOverlap(result);

  const existingEntries = await loadEntries(root);
  const existingIds = new Set(existingEntries.map((entry) => entry.id));
  const proposedIds = new Set<string>();
  const newConcepts: ConceptProposal[] = [];
  for (const concept of result.concepts) {
    if (!idPattern.test(concept.id)) throw new Error(`${concept.id}: invalid concept id`);
    if (proposedIds.has(concept.id)) throw new Error(`${concept.id}: duplicate concept proposal`);
    proposedIds.add(concept.id);
    if (existingIds.has(concept.id)) continue;
    if (!allowedKinds.has(concept.kind)) throw new Error(`${concept.id}: invalid kind ${concept.kind}`);
    requireString(concept.title, `${concept.id}.title`);
    requireStringArray(concept.aliases, `${concept.id}.aliases`);
    requireStringArray(concept.tags, `${concept.id}.tags`);
    requireString(concept.summaryTyp, `${concept.id}.summaryTyp`);
    requireStringArray(concept.related, `${concept.id}.related`);
    if (concept.wikidataQID !== null && !wikidataPattern.test(concept.wikidataQID)) {
      throw new Error(`${concept.id}.wikidataQID is invalid`);
    }
    if (concept.primarySource.document !== result.document) {
      throw new Error(`${concept.id}: primary source must be in ${result.document}`);
    }
    if (!labelPattern.test(concept.primarySource.label)) {
      throw new Error(`${concept.id}: invalid primary source label ${concept.primarySource.label}`);
    }
    if (!allowedKinds.has(concept.primarySource.kind)) {
      throw new Error(`${concept.id}: invalid primary source kind ${concept.primarySource.kind}`);
    }
    newConcepts.push(concept);
  }

  const knownIds = new Set([...existingIds, ...proposedIds]);
  for (const concept of newConcepts) {
    for (const related of concept.related) {
      if (!knownIds.has(related)) throw new Error(`${concept.id}: related id does not exist: ${related}`);
      if (related === concept.id) throw new Error(`${concept.id}: concept cannot relate to itself`);
    }
  }
  for (const edit of result.edits) {
    if (!knownIds.has(edit.entryId)) throw new Error(`${edit.document}: unknown entry id ${edit.entryId}`);
  }


  const newPrimaryLabels = new Set(newConcepts.map((concept) => concept.primarySource.label));
  const editedLabels = new Set<string>();
  for (const edit of result.labelEdits) {
    if (!newPrimaryLabels.has(edit.label)) {
      throw new Error(`${edit.document}: label edit ${edit.label} is not a new concept primary source`);
    }
    if (editedLabels.has(edit.label)) throw new Error(`${edit.document}: duplicate label edit ${edit.label}`);
    editedLabels.add(edit.label);
  }

  const operations = [
    ...result.edits.map((edit) => ({ start: edit.start, end: edit.end, replacement: edit.replacement })),
    ...result.labelEdits.map((edit) => ({ start: edit.start, end: edit.end, replacement: edit.replacement })),
  ].sort((left, right) => right.start - left.start);
  let nextSource = source;
  for (const operation of operations) {
    nextSource = nextSource.slice(0, operation.start) + operation.replacement + nextSource.slice(operation.end);
  }

  const referenceTargets = new Map<string, string>();
  for (const entry of existingEntries) {
    referenceTargets.set(`${entry.primarySource.document}#${entry.primarySource.label}`, entry.id);
    for (const section of entry.sections) {
      if (section.source?.referenceTarget) {
        referenceTargets.set(`${section.source.document}#${section.source.label}`, entry.id);
      }
    }
  }
  for (const concept of newConcepts) {
    const sourceKey = `${concept.primarySource.document}#${concept.primarySource.label}`;
    const mapped = referenceTargets.get(sourceKey);
    if (mapped && mapped !== concept.id) throw new Error(`${sourceKey} already maps to ${mapped}`);
    referenceTargets.set(sourceKey, concept.id);
    const labelCount = countLabel(nextSource, concept.primarySource.label);
    if (labelCount !== 1) {
      throw new Error(`${concept.id}: final source must contain exactly one <${concept.primarySource.label}> (found ${labelCount})`);
    }
    const directory = path.join(root, "ponder/entries", concept.id);
    if (await pathExists(directory)) throw new Error(`${concept.id}: entry directory already exists`);
  }

  await writeFile(target, nextSource);
  let created = 0;
  for (const concept of newConcepts) {
    const directory = path.join(root, "ponder/entries", concept.id);
    await mkdir(directory, { recursive: false });
    const entry = {
      id: concept.id,
      kind: concept.kind,
      title: concept.title,
      ...(concept.wikidataQID ? { wikidataQID: concept.wikidataQID } : {}),
      aliases: concept.aliases,
      tags: concept.tags,
      summary: "summary.typ",
      primarySource: concept.primarySource,
      sections: [{
        title: primarySectionTitle(concept.kind),
        kind: concept.kind,
        source: concept.primarySource,
      }],
      related: concept.related,
    };
    await writeFile(path.join(directory, "entry.yml"), YAML.stringify(entry));
    await writeFile(path.join(directory, "summary.typ"), `${concept.summaryTyp.trim()}\n`);
    created += 1;
  }

  return { edits: result.edits.length, labels: result.labelEdits.length, concepts: created };
}
