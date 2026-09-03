#!/usr/bin/env node
import path from "node:path";
import { fileURLToPath } from "node:url";
import { applyBatchResult, prepareBatch } from "./batch.js";
import { exportPonder } from "./export.js";
import { listCourses, resolveConfigFile } from "./load.js";
import { validate } from "./validate.js";

const usage = `Usage:
  ponder validate [--course <name>|all] [--config <file>] [--all]
  ponder export   [--course <name>|all] [--config <file>] [--site-root <path>] [--no-cache] [--prune]
  ponder batch    [apply <reviewed-result.json>] [--course <name>] [--config <file>]

All commands accept --root <path> to point at a notes tree other than the
one containing this script.`;

function parseArgs(argv: string[]) {
  const flags = new Map<string, string | true>();
  const positional: string[] = [];
  for (let index = 0; index < argv.length; index += 1) {
    const arg = argv[index];
    // pnpm forwards its own `--` separator.
    if (arg === "--") continue;
    if (!arg.startsWith("--")) {
      positional.push(arg);
      continue;
    }
    const next = argv[index + 1];
    if (next !== undefined && !next.startsWith("--")) {
      flags.set(arg.slice(2), next);
      index += 1;
    } else {
      flags.set(arg.slice(2), true);
    }
  }
  return { flags, positional };
}

const [command, ...argv] = process.argv.slice(2);
const { flags, positional } = parseArgs(argv);
const flag = (name: string) => flags.get(name);
const text = (name: string) => {
  const value = flags.get(name);
  return typeof value === "string" ? value : undefined;
};

/// The notes repository root: two levels above `ponder/scripts`. Commands run
/// from inside `ponder/`, so the cwd is not the root any more.
const root = path.resolve(
  text("root") ?? path.join(path.dirname(fileURLToPath(import.meta.url)), "../.."),
);

/// `--course all` fans out over every configured profile, sharing the compiled
/// fragment cache so the extra courses cost little.
async function selectedCourses() {
  const course = text("course");
  if (course !== "all") return [{ course, configFile: resolveConfigFile({ course, configFile: text("config") }) }];
  const courses = await listCourses(root);
  if (!courses.length) throw new Error("No course profiles found in ponder/courses");
  return courses.map((name) => ({ course: name, configFile: resolveConfigFile({ course: name }) }));
}

try {
  if (command === "validate") {
    for (const { configFile } of await selectedCourses()) {
      const { config, entries, referenceTargets, courseIds, notes } = await validate(root, configFile, { all: flag("all") === true });
      for (const note of notes) console.warn(`note: ${note}`);
      const scope = flag("all") === true ? "the whole registry" : `${config.course} (${courseIds.size} ids in scope)`;
      console.log(`Validated ${entries.length} entries and ${referenceTargets.size} reference targets across ${scope}.`);
    }
  } else if (command === "export") {
    const siteRootValue = text("site-root");
    const siteRoot = siteRootValue ? path.resolve(siteRootValue) : undefined;
    const selected = await selectedCourses();
    for (const [position, { configFile }] of selected.entries()) {
      const metrics = await exportPonder(root, {
        configFile,
        siteRoot,
        useCache: flag("no-cache") !== true,
        prune: flag("prune") === true,
        warnIncompleteShards: position === selected.length - 1,
      });
      console.log(JSON.stringify(metrics, null, 2));
    }
  } else if (command === "batch") {
    const configFile = resolveConfigFile({ course: text("course"), configFile: text("config") });
    if (positional[0] === "apply") {
      if (!positional[1]) throw new Error("Usage: pnpm ponder:batch apply <reviewed-result.json>");
      const applied = await applyBatchResult(root, positional[1], configFile);
      console.log(`Applied ${applied.edits} annotations, ${applied.labels} labels, and ${applied.concepts} concepts.`);
    } else {
      console.log(`Prepared ${await prepareBatch(root, positional[0] || undefined, configFile)}`);
    }
  } else {
    throw new Error(usage);
  }
} catch (error) {
  console.error(error instanceof Error ? error.message : error);
  process.exitCode = 1;
}
