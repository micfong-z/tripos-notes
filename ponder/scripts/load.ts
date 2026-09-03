import { readFile, readdir } from "node:fs/promises";
import path from "node:path";
import YAML from "yaml";
import type { PonderConfig, PonderEntry } from "./types.js";

const DEFAULTS_FILE = "ponder/courses/_defaults.yml";
const POINTER_FILE = "ponder/config.yml";
const required = ["course", "title", "document", "sourceBase", "typstVersion"] as const;

export const courseFile = (course: string) => `ponder/courses/${course}.yml`;

/// The course directory that owns a configuration, for example `Groups`.
export const courseRoot = (config: Pick<PonderConfig, "document">) =>
  path.dirname(config.document).replaceAll(path.sep, "/");

export const inCourse = (document: string, root: string) => document === root || document.startsWith(`${root}/`);

async function readYaml<T>(file: string): Promise<T | undefined> {
  try {
    return YAML.parse(await readFile(file, "utf8")) as T;
  } catch (error) {
    if ((error as NodeJS.ErrnoException).code === "ENOENT") return undefined;
    throw error;
  }
}

/// Every course profile in `ponder/courses`, excluding the shared defaults.
export async function listCourses(root: string) {
  const directory = path.resolve(root, "ponder/courses");
  const files = await readdir(directory).catch(() => [] as string[]);
  return files
    .filter((file) => file.endsWith(".yml") && !file.startsWith("_"))
    .map((file) => path.basename(file, ".yml"))
    .sort();
}

/// Chapters are numbered, so a sorted glob reproduces the reading order without
/// anyone having to remember to add the next chapter to a list.
async function defaultBatchDocuments(root: string, document: string) {
  const directory = path.join(courseRoot({ document }), "chapters");
  const files = await readdir(path.resolve(root, directory)).catch(() => [] as string[]);
  return files
    .map((file) => ({ file, number: Number(/^chapter-(\d+)\.typ$/.exec(file)?.[1]) }))
    .filter((candidate) => Number.isFinite(candidate.number))
    .sort((left, right) => left.number - right.number)
    .map((candidate) => `${directory}/${candidate.file}`);
}

/// Resolves the profile to use: an explicit `--config` path, a `--course` name,
/// or the `defaultCourse` named by `ponder/config.yml`.
export function resolveConfigFile(options: { course?: string; configFile?: string }) {
  if (options.configFile) return options.configFile;
  if (options.course) return courseFile(options.course);
  return POINTER_FILE;
}

export async function loadConfig(root: string, configFile = POINTER_FILE): Promise<PonderConfig> {
  let file = configFile;
  let profile = await readYaml<Partial<PonderConfig> & { defaultCourse?: string }>(path.resolve(root, file));
  if (!profile) throw new Error(`${file} does not exist`);

  if (!profile.course && profile.defaultCourse) {
    file = courseFile(profile.defaultCourse);
    profile = await readYaml(path.resolve(root, file));
    if (!profile) throw new Error(`${configFile} points at ${file}, which does not exist`);
  }

  const defaults = (await readYaml<Partial<PonderConfig>>(path.resolve(root, DEFAULTS_FILE))) ?? {};
  const config = {
    ...defaults,
    ...profile,
    budgets: { ...defaults.budgets, ...profile.budgets },
  } as PonderConfig;

  const missing = required.filter((key) => !config[key]);
  if (missing.length) throw new Error(`${file} is missing required keys: ${missing.join(", ")}`);

  return {
    ...config,
    outputName: config.outputName ?? `${config.course}.html`,
    prelude: config.prelude ?? `${courseRoot(config)}/prelude.typ`,
    htmlTheme: config.htmlTheme ?? "dark",
    batchDocuments: config.batchDocuments ?? await defaultBatchDocuments(root, config.document),
  };
}

export interface EntryRegistry {
  entries: PonderEntry[];
  /// Directories that could not be read or parsed at all. Course-scoped
  /// validation reports these as notes when they belong to another course, so
  /// one agent's half-written entry cannot fail another agent's course.
  failures: Array<{ directory: string; message: string }>;
}

export async function loadEntryRegistry(root: string): Promise<EntryRegistry> {
  const entriesRoot = path.join(root, "ponder/entries");
  const directories = (await readdir(entriesRoot, { withFileTypes: true }))
    .filter((entry) => entry.isDirectory())
    .map((entry) => entry.name)
    .sort();

  const entries: PonderEntry[] = [];
  const failures: EntryRegistry["failures"] = [];
  type Loaded = { directory: string; entry: PonderEntry } | { directory: string; message: string };
  const loaded: Loaded[] = await Promise.all(directories.map(async (directory): Promise<Loaded> => {
    try {
      const entry = YAML.parse(
        await readFile(path.join(entriesRoot, directory, "entry.yml"), "utf8"),
      ) as PonderEntry;
      if (!entry || typeof entry !== "object") throw new Error("entry.yml is empty");
      entry.directory = path.join(entriesRoot, directory);
      return { directory, entry };
    } catch (error) {
      return { directory, message: error instanceof Error ? error.message : String(error) };
    }
  }));
  for (const result of loaded) {
    if ("entry" in result) entries.push(result.entry);
    else failures.push({ directory: result.directory, message: result.message });
  }
  return { entries, failures };
}

export async function loadEntries(root: string): Promise<PonderEntry[]> {
  const { entries, failures } = await loadEntryRegistry(root);
  if (failures.length) {
    throw new Error(`Unreadable ponder entries:\n- ${failures.map((failure) => `${failure.directory}: ${failure.message}`).join("\n- ")}`);
  }
  return entries;
}
